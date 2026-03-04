import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/chat.dart';
import '../models/threads.dart';

class ChatService {
  final supabase = Supabase.instance.client;

  // Generate a deterministic chat ID based on the two user IDs
  String _generateChatId(String senderID, String receiverID) {
    final ids = [senderID, receiverID]..sort();
    final raw = '${ids[0]}_${ids[1]}';
    return md5.convert(utf8.encode(raw)).toString();
  }

  Future<void> sendMessage({
    required String receiverId,
    required String content,
  }) async {
    final supabase = Supabase.instance.client;
    final senderId = supabase.auth.currentUser!.id;

    try {
      // Generate deterministic chat id for the user pair
      final chatId = _generateChatId(senderId, receiverId);

      // Ensure chat exists (create if missing)
      final existingChat = await supabase
          .from('chats')
          .select('id')
          .eq('id', chatId)
          .maybeSingle();

      if (existingChat == null) {
        await supabase.from('chats').insert({
          'id': chatId,
          'profile_id': senderId,
          'content': content,
          'is_read': false,
          'created_at': DateTime.now().toIso8601String(),
        });
      } else {
        // Update the chat with the latest message content
        await supabase
            .from('chats')
            .update({
              'content': content,
              'is_read': false,
              'created_at': DateTime.now().toIso8601String(),
            })
            .eq('id', chatId);
      }

      // Insert message with chat_id
      await supabase.from('messages').insert({
        'chat_id': chatId,
        'sender_id': senderId,
        'receiver_id': receiverId,
        'content': content,
        'is_read': false,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ChatThread>> streamThreads() {
  final myId = Supabase.instance.client.auth.currentUser!.id;

  return Supabase.instance.client
      .from('chats')
      .stream(primaryKey: ['id'])
      .order('created_at', ascending: false)
      .map((rows) {
        final Map<String, List<Map<String, dynamic>>> grouped = {};

        for (final row in rows) {
          final other = row['profile_id'] == myId
              ? row['receiver_id']
              : row['sender_id'];

          grouped.putIfAbsent(other, () => []).add(row);
        }

        return grouped.entries.map((e) {
          final msgs = e.value;

          final last = ChatMessage.fromJson(msgs.first);

          final unread = msgs
              .where((m) =>
                  m['receiver_id'] == myId &&
                  m['is_read'] == false)
              .length;

          return ChatThread(
            receiverId: e.key,
            userName: 'User', // load from profiles table
            avatar: '',
            lastMessage: last,
            unreadCount: unread,
          );
        }).toList();
      });
}

  Stream<List<ChatMessage>> streamMessages(String otherUserId) {
    final myId = supabase.auth.currentUser!.id;

    return supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((rows) => rows
            .where((m) =>
                (m['sender_id'] == myId &&
                    m['receiver_id'] == otherUserId) ||
                (m['sender_id'] == otherUserId &&
                    m['receiver_id'] == myId))
            .map((e) => ChatMessage.fromJson(e))
            .toList());
  }
}
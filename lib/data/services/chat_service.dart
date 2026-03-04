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
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .asyncMap((rows) async {
          // Group messages by conversation (identify the other user)
          final Map<String, List<Map<String, dynamic>>> grouped = {};

          for (final row in rows) {
            // Determine who the other user is in this conversation
            final otherUserId = row['sender_id'] == myId
                ? row['receiver_id']
                : row['sender_id'];

            grouped.putIfAbsent(otherUserId, () => []).add(row);
          }

          // Create ChatThread for each conversation (fetch user data async)
          final threads = await Future.wait(
            grouped.entries.map((e) async {
              final msgs = e.value; // All messages in this conversation
              final otherUserId = e.key; // The other user's ID

              // Get the most recent message
              final lastMsg = msgs.first;
              final lastMessage = ChatMessage.fromJson(lastMsg);

              // Count unread messages (messages sent to me that I haven't read)
              final unreadCount = msgs
                  .where(
                    (m) => m['receiver_id'] == myId && m['is_read'] == false,
                  )
                  .length;

              // Fetch user data from the users table
              final userRes = await supabase
                  .from('users')
                  .select()
                  .eq('id', otherUserId)
                  .maybeSingle();

              // Create UserModel from the fetched data
              UserModel user = UserModel(
                id: otherUserId,
                username: userRes?['username'] ?? 'Unknown',
                createdAt: userRes?['created_at'] != null
                    ? DateTime.parse(userRes!['created_at'])
                    : DateTime.now(),
                firstName: userRes?['first_name'],
                lastName: userRes?['last_name'],
                email: userRes?['email'],
                mobileNumber: userRes?['mobile_number'],
                avatarUrl: userRes?['avatar_url'],
              );

              return ChatThread(
                receiverId: otherUserId,
                user: user,
                recentMessage: lastMessage,
                unreadCount: unreadCount,
              );
            }),
          );

          return threads;
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
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/chat.dart';
import '../../data/models/threads.dart';

class ChatService {
  final supabase = Supabase.instance.client;

  Future<void> sendMessage({
    required String receiverId,
    required String content,
  }) async {
    final senderId = supabase.auth.currentUser!.id;

    await supabase.from('chats').insert({
      'sender_id': senderId,
      'receiver_id': receiverId,
      'content': content,
    });
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
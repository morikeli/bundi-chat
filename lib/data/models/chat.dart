import 'package:supabase_flutter/supabase_flutter.dart';

class ChatMessage {
  final String id;
  final String text;
  final String senderId;
  final String receiverId;
  final bool isRead;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
    required this.isRead,
    required this.receiverId,
  });

  bool get isSentByMe => senderId == Supabase.instance.client.auth.currentUser?.id;

  ChatMessage copyWith({
    String? id,
    String? text,
    String? senderId,
    String? receiverId,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'senderId': senderId,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      text: json['text'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      isRead: json['isRead'],
    );
  }

  @override
  String toString() {
    return '''ChatMessage(id: $id, text: $text, senderId: $senderId, receiverId: $receiverId, timestamp: $timestamp)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatMessage &&
        other.id == id &&
        other.text == text &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^ text.hashCode ^ senderId.hashCode ^ timestamp.hashCode;
  }
}

// List<ChatMessage> messages = [
//   ChatMessage(
//     id: '1',
//     text: 'Hello, how are you?',
//     senderId: 'user1',
//     receiverId: 'user2',
//     timestamp: DateTime.now().subtract(Duration(minutes: 5)),
//     isRead: false,
//   ),
//   ChatMessage(
//     id: '2',
//     text: 'I am good, thanks! How about you?',
//     senderId: 'user2',
//     receiverId: 'user1',
//     timestamp: DateTime.now().subtract(Duration(minutes: 4)),
//     isRead: true,
//   ),
//   ChatMessage(
//     id: '3',
//     text: 'I am doing well too. What are you up to?',
//     senderId: 'user1',
//     receiverId: 'user2',
//     timestamp: DateTime.now().subtract(Duration(minutes: 3)),
//     isRead: false,
//   ),
//   ChatMessage(
//     id: '4',
//     text: 'Just working on a Flutter project.',
//     senderId: 'user2',
//     receiverId: 'user1',
//     timestamp: DateTime.now().subtract(Duration(minutes: 2)),
//     isRead: false,
//   ),
// ];

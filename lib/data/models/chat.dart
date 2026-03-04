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

  bool get isSentByMe =>
      senderId == Supabase.instance.client.auth.currentUser?.id;

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
      'content': text,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'created_at': timestamp.millisecondsSinceEpoch,
      'is_read': isRead,
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

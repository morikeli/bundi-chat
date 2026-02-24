import 'package:flutter/foundation.dart';

import 'chat.dart';

class ChatThread {
  final String userId;
  final String userName;
  final String avatar;
  final List<ChatMessage> messages;

  const ChatThread({
    required this.userId,
    required this.userName,
    required this.avatar,
    required this.messages,
  });

  ChatThread copyWith({
    String? userId,
    String? userName,
    String? avatar,
    List<ChatMessage>? messages,
  }) {
    return ChatThread(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      avatar: avatar ?? this.avatar,
      messages: messages ?? this.messages,
    );
  }

  ChatMessage get lastMessage => messages.last;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'avatar': avatar,
      'messages': messages.map((x) => x.toJson()).toList(),
    };
  }

  factory ChatThread.fromJson(Map<String, dynamic> json) {
    return ChatThread(
      userId: json['userId'],
      userName: json['userName'],
      avatar: json['avatar'],
      messages: List<ChatMessage>.from(
        json['messages']?.map((x) => ChatMessage.fromJson(x)),
      ),
    );
  }

  @override
  String toString() {
    return '''ChatThread(userId: $userId, userName: $userName, avatar: $avatar, messages: $messages)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatThread &&
        other.userId == userId &&
        other.userName == userName &&
        other.avatar == avatar &&
        listEquals(other.messages, messages);
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userName.hashCode ^
        avatar.hashCode ^
        messages.hashCode;
  }
}

List<ChatThread> threads = [
  ChatThread(
    userId: '1',
    userName: 'Test User',
    avatar: 'assets/imgs/dps/1.jpg',
    messages: messages,
  ),
  ChatThread(
    userId: '2',
    userName: 'Brenda Jones',
    avatar: 'assets/imgs/dps/8.jpg',
    messages: messages,
  ),
  ChatThread(
    userId: '3',
    userName: 'Amanda Jepson',
    avatar: 'assets/imgs/dps/9.jpg',
    messages: messages,
  ),
  ChatThread(
    userId: '4',
    userName: 'Kelvin Anderson',
    avatar: 'assets/imgs/dps/5.jpg',
    messages: messages,
  ),
  ChatThread(
    userId: '5',
    userName: 'Yule Msee',
    avatar: 'assets/imgs/dps/18.jpg',
    messages: messages,
  ),
];

import 'chat.dart';

class ChatThread {
  final String receiverId;
  final String userName;
  final String avatar;
  final ChatMessage lastMessage;
  final int unreadCount;

  const ChatThread({
    required this.receiverId,
    required this.userName,
    required this.avatar,
    required this.lastMessage,
    required this.unreadCount,
  });

  ChatThread copyWith({
    String? receiverId,
    String? userName,
    String? avatar,
    ChatMessage? lastMessage,
    int? unreadCount,
  }) {
    return ChatThread(
      receiverId: receiverId ?? this.receiverId,
      userName: userName ?? this.userName,
      avatar: avatar ?? this.avatar,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  // ChatMessage get lastMessage => messages.last;

  Map<String, dynamic> toJson() {
    return {
      'receiverId': receiverId,
      'userName': userName,
      'avatar': avatar,
      // 'messages': messages.map((x) => x.toJson()).toList(),
    };
  }

  factory ChatThread.fromJson(Map<String, dynamic> json) {
    return ChatThread(
      receiverId: json['receiverId'],
      userName: json['userName'],
      avatar: json['avatar'],
      lastMessage: ChatMessage.fromJson(json['lastMessage']),
      unreadCount: json['unreadCount'],
    );
  }

  @override
  String toString() {
    return '''ChatThread(receiverId: $receiverId, userName: $userName, avatar: $avatar, lastMessage: $lastMessage, unreadCount: $unreadCount)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatThread &&
        other.receiverId == receiverId &&
        other.userName == userName &&
        other.avatar == avatar &&
        other.lastMessage == lastMessage &&
        other.unreadCount == unreadCount;
  }

  @override
  int get hashCode {
    return receiverId.hashCode ^
        userName.hashCode ^
        avatar.hashCode ^
        lastMessage.hashCode ^
        unreadCount.hashCode;
  }
}

// List<ChatThread> threads = [
//   ChatThread(
//     receiverId: '1',
//     userName: 'Test User',
//     avatar: 'assets/imgs/dps/1.jpg',
//     lastMessage: messages.last,
//     unreadCount: 0,
//   ),
//   ChatThread(
//     receiverId: '2',
//     userName: 'Brenda Jones',
//     avatar: 'assets/imgs/dps/8.jpg',
//     lastMessage: messages[1],
//     unreadCount: 2,
//   ),
//   ChatThread(
//     receiverId: '3',
//     userName: 'Amanda Jepson',
//     avatar: 'assets/imgs/dps/9.jpg',
//     lastMessage: messages[2],
//     unreadCount: 0,
//   ),
//   ChatThread(
//     receiverId: '4',
//     userName: 'Kelvin Anderson',
//     avatar: 'assets/imgs/dps/5.jpg',
//     lastMessage: messages[3],
//     unreadCount: 0,
//   ),
//   ChatThread(
//     receiverId: '5',
//     userName: 'Yule Msee',
//     avatar: 'assets/imgs/dps/18.jpg',
//     lastMessage: messages[4],
//     unreadCount: 0,
//   ),
// ];

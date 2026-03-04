import 'chat.dart';
import 'user.dart';

class ChatThread {
  final String receiverId;
  final UserModel user;
  final ChatMessage recentMessage;
  final int unreadCount;

  const ChatThread({
    required this.receiverId,
    required this.user,
    required this.recentMessage,
    required this.unreadCount,
  });

  ChatThread copyWith({
    String? receiverId,
    UserModel? user,
    ChatMessage? recentMessage,
    int? unreadCount,
  }) {
    return ChatThread(
      receiverId: receiverId ?? this.receiverId,
      user: user ?? this.user,
      recentMessage: recentMessage ?? this.recentMessage,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  // ChatMessage get lastMessage => messages.last;

  Map<String, dynamic> toJson() {
    return {
      'receiverId': receiverId,
      'user': user.toJson(),
      'recentMessage': recentMessage.toJson(),
      'unreadCount': unreadCount,
    };
  }

  factory ChatThread.fromJson(Map<String, dynamic> json) {
    return ChatThread(
      receiverId: json['receiverId'],
      user: UserModel.fromJson(json['user']),
      recentMessage: ChatMessage.fromJson(json['recentMessage']),
      unreadCount: json['unreadCount'],
    );
  }

  @override
  String toString() {
    return '''ChatThread(receiverId: $receiverId, user: $user, recentMessage: $recentMessage, unreadCount: $unreadCount)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatThread &&
        other.receiverId == receiverId &&
        other.user == user &&
        other.recentMessage == recentMessage &&
        other.unreadCount == unreadCount;
  }

  @override
  int get hashCode {
    return receiverId.hashCode ^
        user.hashCode ^
        recentMessage.hashCode ^
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

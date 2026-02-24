class ChatMessage {
  final String id;
  final String text;
  final bool isMe;
  final bool isRead;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isMe,
    required this.timestamp,
    required this.isRead,
  });

  ChatMessage copyWith({
    String? id,
    String? text,
    bool? isMe,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      isMe: isMe ?? this.isMe,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isMe': isMe,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      text: json['text'],
      isMe: json['isMe'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
      isRead: json['isRead'],
    );
  }

  @override
  String toString() {
    return '''ChatMessage(id: $id, text: $text, isMe: $isMe, timestamp: $timestamp)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatMessage &&
        other.id == id &&
        other.text == text &&
        other.isMe == isMe &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^ text.hashCode ^ isMe.hashCode ^ timestamp.hashCode;
  }
}


List<ChatMessage> messages = [
  ChatMessage(
    id: '1',
    text: 'Hello, how are you?',
    isMe: false,
    timestamp: DateTime.now().subtract(Duration(minutes: 5)),
    isRead: false,
  ),
  ChatMessage(
    id: '2',
    text: 'I am good, thanks! How about you?',
    isMe: true,
    timestamp: DateTime.now().subtract(Duration(minutes: 4)),
    isRead: true,
  ),
  ChatMessage(
    id: '3',
    text: 'I am doing well too. What are you up to?',
    isMe: false,
    timestamp: DateTime.now().subtract(Duration(minutes: 3)),
    isRead: false,
  ),
  ChatMessage(
    id: '4',
    text: 'Just working on a Flutter project.',
    isMe: true,
    timestamp: DateTime.now().subtract(Duration(minutes: 2)),
    isRead: false,
  ),
];

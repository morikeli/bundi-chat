class Friends {
  final String id;
  final String followingId;
  final String followerId;
  final DateTime createdAt;

  const Friends({
    required this.id,
    required this.followingId,
    required this.followerId,
    required this.createdAt,
  });

  Friends copyWith({
    String? id,
    String? followingId,
    String? followerId,
    DateTime? createdAt,
  }) {
    return Friends(
      id: id ?? this.id,
      followingId: followingId ?? this.followingId,
      followerId: followerId ?? this.followerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'followingId': followingId,
      'followerId': followerId,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Friends.fromJson(Map<String, dynamic> json) {
    return Friends(
      id: json['id'],
      followingId: json['followingId'],
      followerId: json['followerId'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
    );
  }

  @override
  String toString() {
    return '''Friends(id: $id, followingId: $followingId, followerId: $followerId, createdAt: $createdAt)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Friends &&
      other.id == id &&
      other.followingId == followingId &&
      other.followerId == followerId &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      followingId.hashCode ^
      followerId.hashCode ^
      createdAt.hashCode;
  }
}

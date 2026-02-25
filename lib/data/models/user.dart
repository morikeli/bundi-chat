class UserModel {
  final String id;
  final String username;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.username,
    required this.createdAt,
  });

  UserModel copyWith({String? id, String? username, DateTime? createdAt}) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
    );
  }

  @override
  String toString() =>
      '''UserModel(id: $id, username: $username, createdAt: $createdAt)''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.username == username &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ createdAt.hashCode;
}

class UserModel {
  final String id;
  final String? firstName, lastName;
  final String username;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.createdAt,
    this.firstName,
    this.lastName,
  });

  UserModel copyWith({String? id, String? username, DateTime? createdAt}) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName,
      lastName: lastName,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
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

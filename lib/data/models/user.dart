class UserModel {
  final String id;
  final String? firstName, lastName, email, mobileNumber, avatarUrl;
  final String username;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.createdAt,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.avatarUrl,
  });

  UserModel copyWith({
    String? id,
    String? username,
    DateTime? createdAt,
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    String? avatarUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
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
      'email': email,
      'mobile_number': mobileNumber,
      'avatar_url': avatarUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // 1. Safely grab the metadata map
    final Map<String, dynamic> metadata = json['user_metadata'] ?? {};

    return UserModel(
      id: json['id'] as String,

      // 2. Pull user metadata fields with fallback to top-level if not found
      username: json['username'] as String? ?? metadata['username'],
      firstName: json['first_name'] as String? ?? metadata['first_name'],
      lastName: json['last_name'] as String? ?? metadata['last_name'],
      email: json['email'] as String? ?? metadata['email'],
      mobileNumber:
          json['mobile_number'] as String? ?? metadata['mobile_number'],
      avatarUrl: json['avatar_url'] as String? ?? metadata['avatar_url'],

      // 3. Parse the ISO8601 String (2026-02-26T10:01:08...)
      // instead of expecting Milliseconds
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  @override
  String toString() =>
      '''UserModel(id: $id, username: $username, email: $email, mobileNumber: $mobileNumber, avatarUrl: $avatarUrl, createdAt: $createdAt)''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.username == username &&
        other.email == email &&
        other.mobileNumber == mobileNumber &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      username.hashCode ^
      email.hashCode ^
      mobileNumber.hashCode ^
      createdAt.hashCode;
}

class UserModel {
  final String id;
  final String? firstName, lastName, email, mobileNumber;
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
  });

  UserModel copyWith({String? id, String? username, DateTime? createdAt}) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      mobileNumber: mobileNumber,
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
      '''UserModel(id: $id, username: $username, email: $email, mobileNumber: $mobileNumber, createdAt: $createdAt)''';

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

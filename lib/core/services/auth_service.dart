import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/user.dart';

class AuthService {
  final _auth = Supabase.instance.client.auth;

  Future<void> login(String email, String password) async {
    final response = await _auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.session == null) {
      throw AuthApiException(
        'Invalid credentials provided!',
        statusCode: "400",
      );
    }
  }

  /// Signs up a new user with the provided email, mobile number, password, and metadata (first & last name).
  /// Returns a [UserModel] representing the newly created user.
  Future<UserModel> signup(
    String email,
    String password,
    Map<String, dynamic> metadata,
  ) async {
    final response = await _auth.signUp(
      email: email,
      password: password,
      data: metadata,
    );
    return UserModel.fromJson(response.user!.toJson());
  }
}

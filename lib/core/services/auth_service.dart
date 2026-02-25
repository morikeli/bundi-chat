import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/user.dart';

class AuthService {
  final _auth = Supabase.instance;

  /// Signs up a new user with the provided email, mobile number, password, and metadata (first & last name).
  /// Returns a [UserModel] representing the newly created user.
  Future<UserModel> signup(
    String email,
    String mobileNumber,
    String password,
    Map<String, dynamic> metadata,
  ) async {
    final response = await _auth.client.auth.signUp(
      email: email,
      password: password,
      phone: mobileNumber,
      data: metadata,
    );
    return UserModel.fromJson(response.user!.toJson());
  }
}

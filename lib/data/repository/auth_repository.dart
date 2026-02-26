import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/services/auth_service.dart';
import '../models/user.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<void> authenticateUser(String email, String password) async {
    try {
      await _authService.login(email, password);
    } on AuthApiException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> createUserAccount(
    String email,
    String password,
    Map<String, dynamic> metadata,
  ) async {
    try {
      return await _authService.signup(email, password, metadata);
    } on AuthApiException catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOutUser() async => await _authService.logout();
}

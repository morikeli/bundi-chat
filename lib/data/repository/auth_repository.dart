import '../../core/services/auth_service.dart';
import '../models/user.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<UserModel> createUserAccount(
    String email,
    String mobileNumber,
    String password,
    Map<String, dynamic> metadata,
  ) async {
    try {
      return await _authService.signup(email, mobileNumber, password, metadata);
    } catch (e) {
      rethrow;
    }
  }

}

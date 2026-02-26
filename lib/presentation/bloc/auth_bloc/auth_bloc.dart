import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user.dart';
import '../../../data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<LoginRequested>(_login);
    on<SignupRequested>(_signUp);
  }

  Future<void> _login(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await _authRepository.authenticateUser(event.email, event.password);
      emit(IsAuthenticated(isAuthenticated: true));
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> _signUp(SignupRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.createUserAccount(
        event.email,
        event.password,
        event.metadata,
      );
      emit(AccountCreated(user: user));
    } catch (e) {
      emit(SignupFailed(errorMessage: e.toString()));
    }
  }
}

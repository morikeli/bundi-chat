part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

final class SignupRequested extends AuthEvent {
  final String email;
  final String password;
  final Map<String, dynamic> metadata;

  SignupRequested({
    required this.email,
    required this.password,
    required this.metadata,
  });
}

final class LogoutRequested extends AuthEvent {}
part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class IsAuthenticated extends AuthState {
  final bool isAuthenticated;

  IsAuthenticated({required this.isAuthenticated});
}

final class AccountCreated extends AuthState {
  final UserModel user;
  
  AccountCreated({required this.user});
}

final class SignupFailed extends AuthState {
  final String errorMessage;

  SignupFailed({required this.errorMessage});
}

final class AuthError extends AuthState {
  final String errorMessage;

  AuthError({required this.errorMessage});
}
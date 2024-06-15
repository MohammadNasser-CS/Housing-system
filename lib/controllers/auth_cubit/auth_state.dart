part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}
final class AuthLoaded extends AuthState {
  
}

final class AuthSuccess extends AuthState {
  final UserModel user;
  AuthSuccess({required this.user});
}
final class OwnerAuthSuccess extends AuthState {
  final String message;
  OwnerAuthSuccess({required this.message});
}
final class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

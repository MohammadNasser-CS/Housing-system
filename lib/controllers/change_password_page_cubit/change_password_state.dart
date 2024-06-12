part of 'change_password_cubit.dart';

sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}
final class ChangePasswordLoading extends ChangePasswordState {
 
}
final class ChangePasswordVisibilityStatus extends ChangePasswordState {
   final bool newPasswordVisibilityStatu;
  ChangePasswordVisibilityStatus({ this.newPasswordVisibilityStatu=false});
}

final class ChangePasswordLoaded extends ChangePasswordState {
  ChangePasswordLoaded();
}
final class ChangePasswordInvoked extends ChangePasswordState {
  final String message;
  ChangePasswordInvoked({required this.message});
}
final class ChangePasswordError extends ChangePasswordState {
  final String message;
  ChangePasswordError({required this.message});
}

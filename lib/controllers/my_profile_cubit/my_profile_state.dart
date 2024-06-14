part of 'my_profile_cubit.dart';

sealed class MyProfileState {}

final class MyProfileInitial extends MyProfileState {}

final class MyProfileLoading extends MyProfileState {}

final class MyProfileVisibilityStatus extends MyProfileState {
  final bool newPasswordVisibilityStatu;
  MyProfileVisibilityStatus({this.newPasswordVisibilityStatu = false});
}

final class MyProfileLoaded extends MyProfileState {
  MyProfileLoaded();
}

final class MyProfileUpdateInvoked extends MyProfileState {
  final String message;
  MyProfileUpdateInvoked({required this.message});
}

final class MyProfileUpdateError extends MyProfileState {
  final String message;
  MyProfileUpdateError({required this.message});
}

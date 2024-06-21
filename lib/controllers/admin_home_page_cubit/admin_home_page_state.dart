part of 'admin_home_page_cubit.dart';

sealed class AdminHomePageState {}

final class AdminHomePageInitial extends AdminHomePageState {}

final class AdminHomePageLoading extends AdminHomePageState {}

final class AdminHomePageLoaded extends AdminHomePageState {
  final List<OwnersActivationRequestModel> roomRequests;
  AdminHomePageLoaded({required this.roomRequests});
}

final class NoOwenrActicationRequestAndNoRoom extends AdminHomePageState {
  NoOwenrActicationRequestAndNoRoom();
}

final class OwenrActicationRequestDeleted extends AdminHomePageState {
  final String message;
  OwenrActicationRequestDeleted({required this.message});
}
final class AdminHomePageError extends AdminHomePageState {
  final String message;
  AdminHomePageError({required this.message});
}


part of 'my_room_cubit.dart';

sealed class MyRoomState {
  const MyRoomState();
}

final class MyRoomInitial extends MyRoomState {}

final class MyRoomLoading extends MyRoomState {}

final class MyRoomLoaded extends MyRoomState {
  final MyRoomModel room;
  MyRoomLoaded({required this.room});
}

final class RoomRequestsLoaded extends MyRoomState {
  final List<StudentRoomRequestsModel> roomRequests;
  RoomRequestsLoaded({required this.roomRequests});
}

final class NoRequestAndNoRoom extends MyRoomState {
  NoRequestAndNoRoom();
}

final class DayTimeSlotChanged extends MyRoomState {
  final String newDateTime;
  final String requestId;
  DayTimeSlotChanged({required this.newDateTime,required this.requestId});
}
final class RequestDeleted extends MyRoomState {
  final String message;
  RequestDeleted({required this.message});
}
final class MyRoomError extends MyRoomState {
  final String message;
  MyRoomError({required this.message});
}

part of 'my_room_cubit.dart';

sealed class MyRoomState {
  const MyRoomState();
}

final class MyRoomInitial extends MyRoomState {}

final class MyRoomLoading extends MyRoomState {}

final class MyRoomLoaded extends MyRoomState {
  final RoomModel room;
  final HouseModel house;
  MyRoomLoaded({required this.room, required this.house});
}

final class RoomRequestsLoaded extends MyRoomState {
  final List<StudentRoomRequestsModel> roomRequests;
  RoomRequestsLoaded({required this.roomRequests});
}

final class NoRequestAndNoRoom extends MyRoomState {
  NoRequestAndNoRoom();
}

final class MyRoomError extends MyRoomState {
  final String message;
  MyRoomError({required this.message});
}

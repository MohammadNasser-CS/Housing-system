part of 'house_details_cubit.dart';

sealed class HouseDetailsState {
  const HouseDetailsState();
}

final class HouseDetailsInitial extends HouseDetailsState {}

final class HouseDetailsLoading extends HouseDetailsState {}

final class HouseDetailsLoaded extends HouseDetailsState {
  final StudentRoomRequestsModel studentRoomRequestsModel;
  final HouseModel house;
  HouseDetailsLoaded({required this.house,required this.studentRoomRequestsModel});
}

final class HouseAddedToCart extends HouseDetailsState {
  final String houseId;
  HouseAddedToCart({required this.houseId});
}

final class DayTimeSlotChanged extends HouseDetailsState {
 
  DayTimeSlotChanged();
}

final class HouseAddingToCart extends HouseDetailsState {}

final class HouseDetailsError extends HouseDetailsState {
  final String message;
  HouseDetailsError({required this.message});
}

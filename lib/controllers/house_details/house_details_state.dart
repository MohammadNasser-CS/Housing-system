part of 'house_details_cubit.dart';

sealed class HouseDetailsState {
  const HouseDetailsState();
}

final class HouseDetailsInitial extends HouseDetailsState {}

final class HouseDetailsLoading extends HouseDetailsState {}

final class HouseDetailsLoaded extends HouseDetailsState {
  final HouseDetailsModel houseDetails;
  HouseDetailsLoaded({required this.houseDetails});
}
final class HouseAddedToCart extends HouseDetailsState {
  final String houseId;
  HouseAddedToCart({required this.houseId});
}
final class FavroiteDetailsChangedSuccess extends HouseDetailsState {
  final String message;
   FavroiteDetailsChangedSuccess({required this.message});
}
final class RequestReservationDone extends HouseDetailsState {
  final String message;
   RequestReservationDone({required this.message});
}

final class HouseAddingToCart extends HouseDetailsState {}

final class HouseDetailsError extends HouseDetailsState {
  final String message;
  HouseDetailsError({required this.message});
}
final class RoomDetailsLoading extends HouseDetailsState {}
final class RoomDetailsLoaded extends HouseDetailsState {
  final RoomModel room;
  RoomDetailsLoaded({required this.room});
}
final class RoomDetailsError extends HouseDetailsState {
  final String message;
  RoomDetailsError({required this.message});
}

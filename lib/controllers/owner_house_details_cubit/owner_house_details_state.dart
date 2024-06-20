part of 'owner_house_details_cubit.dart';

sealed class OwnerHouseDetailsState {}

final class OwnerHouseDetailsInitial extends OwnerHouseDetailsState {}
final class OwnerHouseDetailsLoading extends OwnerHouseDetailsState {}

final class OwnerHouseDetailsLoaded extends OwnerHouseDetailsState {
  final OwnerHouseDetailsModel houseDetails;
  OwnerHouseDetailsLoaded({required this.houseDetails});
}
final class OwnerHouseAddedToCart extends OwnerHouseDetailsState {
  final String houseId;
  OwnerHouseAddedToCart({required this.houseId});
}
final class OwnerFavroiteDetailsChangedSuccess extends OwnerHouseDetailsState {
  final String message;
   OwnerFavroiteDetailsChangedSuccess({required this.message});
}
final class OwnerRequestReservationDone extends OwnerHouseDetailsState {
  final String message;
   OwnerRequestReservationDone({required this.message});
}

final class OwnerHouseAddingToCart extends OwnerHouseDetailsState {}

final class OwnerHouseDetailsError extends OwnerHouseDetailsState {
  final String message;
  OwnerHouseDetailsError({required this.message});
}
// final class RoomDetailsLoading extends OwnerHouseDetailsState {}
// final class RoomDetailsLoaded extends OwnerHouseDetailsState {
//   final RoomModel room;
//   RoomDetailsLoaded({required this.room});
// }
final class OwnerRoomDetailsError extends OwnerHouseDetailsState {
  final String message;
  OwnerRoomDetailsError({required this.message});
}
final class AddNewRoomSuccess extends OwnerHouseDetailsState {
  final String message;
  AddNewRoomSuccess({required this.message});
}
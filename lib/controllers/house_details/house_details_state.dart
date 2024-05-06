part of 'house_details_cubit.dart';

sealed class HouseDetailsState {
  const HouseDetailsState();
}

final class HouseDetailsInitial extends HouseDetailsState {}
final class HouseDetailsLoading extends HouseDetailsState {}
final class HouseDetailsLoaded extends HouseDetailsState {
  final HouseModel house;
  HouseDetailsLoaded({required this.house});
}

final class QuantityCounterLoaded extends HouseDetailsState {
  final int value;
  QuantityCounterLoaded({required this.value});
}

// final class SizeSelected extends HouseDetailsState {
//   final ItemSize size;
//   SizeSelected({required this.size});
// }

final class HouseAddedToCart extends HouseDetailsState {
  final String houseId;
  HouseAddedToCart({required this.houseId});
}

final class HouseAddingToCart extends HouseDetailsState {}

final class HouseDetailsError extends HouseDetailsState {
  final String message;
  HouseDetailsError({required this.message});
}

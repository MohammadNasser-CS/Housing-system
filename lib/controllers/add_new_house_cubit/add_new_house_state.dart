part of 'add_new_house_cubit.dart';

sealed class AddNewHouseState {}

final class AddNewHouseInitial extends AddNewHouseState {}
final class AddNewHouseLoading extends AddNewHouseState {}

final class AddNewHouseDoneSuccess extends AddNewHouseState {
  final HouseModel house;
  AddNewHouseDoneSuccess({required this.house});
}

final class AddNewHouseError extends AddNewHouseState {
  final String message;
  AddNewHouseError({required this.message});
}

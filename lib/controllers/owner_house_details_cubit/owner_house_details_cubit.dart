import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/auth_exceptions.dart';
import 'package:housing_project/models/houses_models/owner_house_details_model.dart';
import 'package:housing_project/models/houses_models/room_details_models/add_room_model.dart';
import 'package:housing_project/models/houses_models/room_details_models/add_secondary_room_model.dart';
import 'package:housing_project/services/house_owner_services/house_owner_services.dart';

part 'owner_house_details_state.dart';

class OwnerHouseDetailsCubit extends Cubit<OwnerHouseDetailsState> {
  OwnerHouseDetailsCubit() : super(OwnerHouseDetailsInitial());
  final HouseOwnerServices _houseOwnerServices =
      HouseOwnerServicesImplementation();
  Future<void> getOwnerHouseDetails(String houseId) async {
    try {
      emit(OwnerHouseDetailsLoading());
      final houses = await _houseOwnerServices.getOwnerHouseDetails(houseId);
      emit(OwnerHouseDetailsLoaded(houseDetails: houses));
    } on AuthException catch (exp) {
      emit(OwnerHouseDetailsError(message: exp.message));
    } catch (exp) {
      emit(OwnerHouseDetailsError(message: exp.toString()));
    }
  }

  Future<void> addNewRoom(AddRoomModel newRoomModel) async {
    try {
      String message = await _houseOwnerServices.addNewRoom(newRoomModel);
      debugPrint(message);
      emit(AddNewRoomSuccess(message: message));
    } on AuthException catch (exp) {
      emit(OwnerHouseDetailsError(message: exp.message));
    } catch (exp) {
      emit(OwnerHouseDetailsError(message: exp.toString()));
    }
  }

  Future<void> addNewSecondaryRoom(AddSecondaryRoom secondaryRoom) async {
    try {
      String message =
          await _houseOwnerServices.addSeconderyRoom(secondaryRoom);
      debugPrint(message);
      emit(AddNewRoomSuccess(message: message));
    } on AuthException catch (exp) {
      emit(OwnerHouseDetailsError(message: exp.message));
    } catch (exp) {
      emit(OwnerHouseDetailsError(message: exp.toString()));
    }
  }
  // Future<void> changeFavorite(String houseId) async {
  //   try {
  //     emit(OwnerHouseDetailsLoading());
  //     String message = await _studentServices.changeFavorite(houseId);
  //     emit(FavroiteDetailsChangedSuccess(message: message));
  //     getHouseDetails(houseId);
  //   } on AuthException catch (exp) {
  //     emit(OwnerHouseDetailsError(message: exp.message));
  //   } catch (exp) {
  //     emit(OwnerHouseDetailsError(message: exp.toString()));
  //   }
  // }

  // Future<void> getRoomDetails(String roomId) async {
  //   try {
  //     emit(RoomDetailsLoading());
  //     final room = await _studentServices.getRoomDetails(roomId);
  //     emit(RoomDetailsLoaded(room: room));
  //   } on AuthException catch (exp) {
  //     emit(RoomDetailsError(message: exp.message));
  //   } catch (exp) {
  //     emit(RoomDetailsError(message: exp.toString()));
  //   }
  // }

  // Future<void> selectDateTimeSlot(String roomId, String timeSlotId) async {
  //   try {
  //     // emit(RoomDetailsLoading());
  //     String result =
  //         await _studentServices.makeRequestReservation(roomId, timeSlotId);
  //     emit(RequestReservationDone(message: result));
  //   } on AuthException catch (exp) {
  //     emit(RoomDetailsError(message: exp.message));
  //   } catch (exp) {
  //     emit(RoomDetailsError(message: exp.toString()));
  //   }
  //   // emit(DayTimeSlotChanged());
  // }
}

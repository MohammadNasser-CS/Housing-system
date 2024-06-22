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
      emit(AddNewRoomSuccess(message: message));
    } on AuthException catch (exp) {
      emit(OwnerHouseDetailsError(message: exp.message));
    } catch (exp) {
      emit(OwnerHouseDetailsError(message: exp.toString()));
    }
  }

  Future<void> finishRoomReservation(String studentId, String houseId) async {
    try {
      emit(OwnerHouseDetailsLoading());
      String message =
          await _houseOwnerServices.finishRoomReservation(studentId);
      emit(DeleteReservationDone(message: message));
      getOwnerHouseDetails(houseId);
    } on AuthException catch (exp) {
      emit(OwnerHouseDetailsError(message: exp.message));
    } catch (exp) {
      emit(OwnerHouseDetailsError(message: exp.toString()));
    }
  }

  Future<void> updateRoomReservation(
      Map<String, String> updateRequest, String houseId) async {
    try {
      emit(OwnerHouseDetailsLoading());
      String message =
          await _houseOwnerServices.updateRoomReservation(updateRequest);
      emit(UpdatedRoomReservationDone(message: message));
      getOwnerHouseDetails(houseId);
    } on AuthException catch (exp) {
      emit(OwnerHouseDetailsError(message: exp.message));
    } catch (exp) {
      emit(OwnerHouseDetailsError(message: exp.toString()));
    }
  }
}

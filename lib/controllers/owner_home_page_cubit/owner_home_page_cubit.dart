import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/auth_exceptions.dart';
import 'package:housing_project/models/houses_models/house_model.dart';
import 'package:housing_project/models/owner_room_requests_model.dart';
import 'package:housing_project/models/room_requests_model.dart';
import 'package:housing_project/services/house_owner_services/house_owner_services.dart';

part 'owner_home_page_state.dart';

class OwnerHomePageCubit extends Cubit<OwnerHomePageState> {
  OwnerHomePageCubit() : super(OwnerHomePageInitial());
  final HouseOwnerServices _houseOwnerServices =
      HouseOwnerServicesImplementation();
  Future<void> getRequestsData() async {
    try {
      emit(RoomRequestsLoading());
      final requests = await _houseOwnerServices.getHouseOwnerRequests();
      if (requests != null) {
        emit(RoomRequestsLoaded(roomRequests: requests));
      } else {
        emit(NoRequestAndNoRoom());
      }
    } on AuthException catch (exp) {
      emit(MyRoomError(message: exp.message));
    } catch (exp) {
      emit(MyRoomError(message: exp.toString()));
    }
  }

  Future<void> confirmAppointment(String requestId) async {
    try {
      emit(RoomRequestsLoading());
      String message = await _houseOwnerServices.confirmAppointment(requestId);
      emit(RequestDeleted(message: message));
      getRequestsData();
    } on AuthException catch (exp) {
      emit(MyRoomError(message: exp.message));
    } catch (exp) {
      emit(MyRoomError(message: exp.toString()));
    }
  }

  Future<void> acceptRoomReservationRequest(
      Map<String, String> acceptedRequest) async {
    debugPrint('tests');

    try {
      emit(RoomRequestsLoading());
      String message = await _houseOwnerServices
          .acceptRoomReservationRequest(acceptedRequest);
      emit(RequestDeleted(message: message));
      getRequestsData();
    } on AuthException catch (exp) {
      emit(MyRoomError(message: exp.message));
    } catch (exp) {
      emit(MyRoomError(message: exp.toString()));
    }
  }

  Future<void> rejectRequestHouseOwenr(String requestId) async {
    try {
      emit(RoomRequestsLoading());
      String message =
          await _houseOwnerServices.rejectRequestHouseOwenr(requestId);
      emit(RequestDeleted(message: message));
      getRequestsData();
    } on AuthException catch (exp) {
      emit(MyRoomError(message: exp.message));
    } catch (exp) {
      emit(MyRoomError(message: exp.toString()));
    }
  }

  Future<void> getHomeData() async {
    try {
      emit(OwnerHomePageLoading());
      final houses = await _houseOwnerServices.getAllHousesHouseOwner();
      emit(OwnerHomePageLoaded(houses: houses));
    } on AuthException catch (exp) {
      emit(OwnerHomePageError(message: exp.message));
    } catch (exp) {
      emit(OwnerHomePageError(message: exp.toString()));
    }
  }

  Future<void> searchFilled(String houseId) async {
    try {
      emit(OwnerHomePageLoading());
      final houses = await _houseOwnerServices.searchForSpecificHouse(houseId);
      emit(OwnerHomePageLoaded(houses: houses));
    } on AuthException catch (exp) {
      emit(OwnerHomePageError(message: exp.message));
    } catch (exp) {
      emit(OwnerHomePageError(message: exp.toString()));
    }
  }

  void chaneTapView() {
    emit(OwnerHomePageLoading());
    emit(const TapViewChanged());
  }
}

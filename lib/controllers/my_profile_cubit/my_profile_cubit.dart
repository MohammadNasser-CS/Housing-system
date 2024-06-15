import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/services/auth_services/auth_service.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends Cubit<MyProfileState> {
  MyProfileCubit() : super(MyProfileInitial());
  final AuthServices _authServices = AuthServicesImplementation();

  Future<void> updateMyInformation(Map<String, dynamic> newData) async {
    debugPrint(newData.toString());
    emit(MyProfileLoading());
    try {
      String response = await _authServices.updateMyInformation(newData);

      emit(MyProfileUpdateInvoked(message: response));
    } on StateError catch (e) {
      emit(MyProfileUpdateError(message: e.message));
    }
  }
}

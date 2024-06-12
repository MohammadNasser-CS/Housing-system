import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/models/auth_models/owner_auth_model.dart';
import 'package:housing_project/models/auth_models/student_auth_model.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/services/auth_services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthServices _authServices = AuthServicesImplementation();
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    if (await _authServices.login(email, password)) {
      try {
        UserModel? user = await _authServices.getUser();
        debugPrint(user.toString());
        emit(AuthSuccess(user: user!));
      } on StateError catch (e) {
        emit(AuthError(message: e.message));
      }
    }
  }

  Future<void> ownerRegister(OwnerRegisterModel newOwner) async {
    emit(AuthLoading());
    String response = await _authServices.ownerRegister(newOwner);
    debugPrint(response);
  }
  Future<void> studentRegister(StudentRegisterModel newStudent) async {
    emit(AuthLoading());
    // bool response = await _authServices.studnetRegister(newStudent);
    if (await _authServices.studnetRegister(newStudent)) {
      try {
        UserModel? user = await _authServices.getUser();
        emit(AuthSuccess(user: user!));
      } on StateError catch (e) {
        emit(AuthError(message: e.message));
      }
    }
  }

//   Future<void> getUser() async {
//     try {
//       User? user = await _authServices.getUser();
//       if (user != null) {
//         emit(AuthSuccess(user: user));
//       } else {
//         emit(AuthError(message: 'User not found'));
//       }
//     } on FirebaseAuthException catch (e) {
//       emit(AuthError(message: e.message!));
//     }
//   }
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _authServices.logout();
    } on StateError catch (e) {
        emit(AuthError(message: e.message));
      }
  }

}

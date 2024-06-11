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
    // try {
    //   final result = await _authServices.login(email, password);
    //   if (result) {
    //     final User? user = await _authServices.getUser();
    //     emit(AuthSuccess(user: user!));
    //   } else {
    //     emit(AuthError(message: 'Login faild'));
    //   }
    // } on FirebaseAuthException catch (e) {
    //   emit(AuthError(message: e.message!));
    // }
    emit(AuthLoading());
    if (await _authServices.login(email, password)) {
      debugPrint('inside');
      try {
       UserModel? user=await _authServices.getUser();
        emit(AuthSuccess(user: user!));
      } on StateError catch (e) {
        emit(AuthError(message: e.message));
      }
    }

    // Future.delayed(const Duration(seconds: 2), () {
    //   try {
    //     UserModel? authedUser =
    //         dummyUsers.firstWhere((user) => user.email == email);
    //     emit(AuthSuccess(user: authedUser));
    //   } on StateError catch (e) {
    //     emit(AuthError(message: e.message));
    //   }
    // });
    // try {
    //   final result = await _authServices.login(email, password);
    //   if (result) {
    //     final User? user = await _authServices.getUser();
    //     emit(AuthSuccess(user: user!));
    //   } else {
    //     emit(AuthError(message: 'Login faild'));
    //   }
    // } on FirebaseAuthException catch (e) {
    //   emit(AuthError(message: e.message!));
    // }
  }

  Future<void> ownerRegister(OwnerRegisterModel newOwner) async {
    emit(AuthLoading());
    String response = await _authServices.ownerRegister(newOwner);
    debugPrint(response);
  }

  Future<void> studentRegister(StudentRegisterModel newStudent) async {
    emit(AuthLoading());
    String response = await _authServices.studnetRegister(newStudent);
    // if (await _authServices.login(email, password)) {
    //   debugPrint('inside');
    //   try {
    //    UserModel? user=await _authServices.getUser();
    //     emit(AuthSuccess(user: user!));
    //   } on StateError catch (e) {
    //     emit(AuthError(message: e.message));
    //   }
    // }
    debugPrint(response);
    // if(){

    // }else{
    //   emit(AuthError(message: response));
    // }
    // Future.delayed(const Duration(seconds: 2), () {
    //   dummyUsers.add(newUser);
    //   debugPrint(dummyUsers.length.toString());
    //   debugPrint(dummyUsers.toString());
    //   emit(AuthSuccess(user: newUser));
    // });
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

//  Future<void> register(String email, String password, String username) async {
//     emit(AuthLoading());
//     try {
//       final result = await _authServices.register(email, password, username);
//       if (result) {
//         final user = await _authServices.getUser();
//         emit(AuthSuccess(user:user!));
//       } else {
//         emit(AuthError(message:'Register failed'));
//       }
//     } on FirebaseAuthException catch (e) {
//       emit(AuthError(message:e.message!));
//     }
//   }

//   Future<void> logout() async {
//     emit(AuthLoading());
//     try {
//       await _authServices.logout();
//     } on FirebaseAuthException catch (e) {
//       emit(AuthError(message: e.message!));
//     }
//   }
}

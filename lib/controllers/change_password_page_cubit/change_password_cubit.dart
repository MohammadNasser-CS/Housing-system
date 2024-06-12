import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/services/auth_services/auth_service.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
   final AuthServices _authServices = AuthServicesImplementation();
  //  void changeVisibilityStatus(bool visibilityStatus){
  //   emit(ChangePasswordVisibilityStatus( newPasswordVisibilityStatu: !visibilityStatus));
  //  } 
    Future<void> changePassword(String password,String newPassword) async{
    emit(ChangePasswordLoading());
     try {
      String response= await _authServices.changePassword(password,newPassword);
      emit(ChangePasswordInvoked(message: response));
    } on StateError catch (e) {
        emit(ChangePasswordError(message: e.message));
      }
  }
}

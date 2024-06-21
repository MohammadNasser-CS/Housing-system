import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/auth_exceptions.dart';
import 'package:housing_project/models/admin_pages_models/owners_activation_request_model.dart';
import 'package:housing_project/services/admin_services/admin_services.dart';

part 'admin_home_page_state.dart';

class AdminHomePageCubit extends Cubit<AdminHomePageState> {
  AdminHomePageCubit() : super(AdminHomePageInitial());
  final AdminServices _adminServices = AdminServicesImplementation();

  Future<void> getHouseOwnerRequest() async {
    try {
      emit(AdminHomePageLoading());
      final myRoom = await _adminServices.getHouseOwnerRequest();
      if (myRoom != null) {
        emit(AdminHomePageLoaded(roomRequests: myRoom));
      } else {
        emit(NoOwenrActicationRequestAndNoRoom());
      }
    } on AuthException catch (exp) {
      emit(AdminHomePageError(message: exp.message));
    } catch (exp) {
      emit(AdminHomePageError(message: exp.toString()));
    }
  }

  Future<void> acceptHouseOwner(String requestId) async {
    try {
      emit(AdminHomePageLoading());
      String message = await _adminServices.acceptHouseOwner(requestId);
      emit(OwenrActicationRequestDeleted(message: message));
      getHouseOwnerRequest();
    } on AuthException catch (exp) {
      emit(AdminHomePageError(message: exp.message));
    } catch (exp) {
      emit(AdminHomePageError(message: exp.toString()));
    }
  }

  Future<void> rejectHouseOwner(String requestId) async {
    try {
      emit(AdminHomePageLoading());
      String message =
          await _adminServices.rejectHouseOwner(requestId);
      emit(OwenrActicationRequestDeleted(message: message));
      getHouseOwnerRequest();
    } on AuthException catch (exp) {
      emit(AdminHomePageError(message: exp.message));
    } catch (exp) {
      emit(AdminHomePageError(message: exp.toString()));
    }
  }

}

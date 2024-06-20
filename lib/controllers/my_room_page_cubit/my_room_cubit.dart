import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/auth_exceptions.dart';
import 'package:housing_project/models/houses_models/my_room_model.dart';
import 'package:housing_project/models/room_requests_model.dart';
import 'package:housing_project/services/student_services/student_service.dart';

part 'my_room_state.dart';

class MyRoomCubit extends Cubit<MyRoomState> {
  MyRoomCubit() : super(MyRoomInitial());
  final StudentServices _studentServices = StudentServicesImplementation();
  Future<void> getMyRoomData() async {
    try {
      emit(MyRoomLoading());
      final myRoom = await _studentServices.getMyReservationRoom();
      if (myRoom != null) {
        emit(MyRoomLoaded(room: myRoom));
      } else {
        final room = await _studentServices.getReservationRoomRequest();
        if (room != null) {
          emit(RoomRequestsLoaded(roomRequests: room));
        } else {
          emit(NoRequestAndNoRoom());
        }
      }
    } on AuthException catch (exp) {
      emit(MyRoomError(message: exp.message));
    } catch (exp) {
      emit(MyRoomError(message: exp.toString()));
    }
  }

  Future<void> cancelRequest(String requestId) async {
    try {
      emit(MyRoomLoading());
      String message = await _studentServices.cancelRequest(requestId);
      emit(RequestDeleted(message: message));
      getMyRoomData();
    } on AuthException catch (exp) {
      emit(MyRoomError(message: exp.message));
    } catch (exp) {
      emit(MyRoomError(message: exp.toString()));
    }
  }
}

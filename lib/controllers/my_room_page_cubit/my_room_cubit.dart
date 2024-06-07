import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/models/house_model.dart';
import 'package:housing_project/models/room_requests_model.dart';
import 'package:housing_project/models/rooms_model.dart';
import 'package:housing_project/models/user_model.dart';

part 'my_room_state.dart';

class MyRoomCubit extends Cubit<MyRoomState> {
  MyRoomCubit() : super(MyRoomInitial());
  Future<void> getMyRoom(UserModel user) async {
    emit(MyRoomLoading());
    Future.delayed(const Duration(seconds: 2), () {
      final index =
          dummyBedRooms.indexWhere((item) => item.studentName == user.name);
      if (index == -1) {
        final index1 = dummyItems.indexWhere(
            (item) => item.ownerName == dummyBedRooms[index].houseOwnerName);
        emit(
          MyRoomLoaded(room: dummyBedRooms[index], house: dummyItems[index1]),
        );
      } else {
        if (dummyStdRoomRequests.isNotEmpty) {
          emit(RoomRequestsLoaded(roomRequests: dummyStdRoomRequests));
        } else {
          emit(NoRequestAndNoRoom());
        }
      }
    });
  }

  Future<void> selectDateTimeSlot(String newTimeSlot, String requestId) async {
    debugPrint(newTimeSlot);
    emit(DayTimeSlotChanged(newDateTime: newTimeSlot, requestId: requestId));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/models/house_model.dart';
import 'package:housing_project/models/rooms_model.dart';

part 'my_room_state.dart';

class MyRoomCubit extends Cubit<MyRoomState> {
  MyRoomCubit() : super(MyRoomInitial());
  Future<void> getMyRoom(String roomId, String houseId) async {
    emit(MyRoomLoading());
    Future.delayed(const Duration(seconds: 2), () {
      final index =
          dummyRooms.indexWhere((item) => item.ownerStudentId == roomId);
      final index1 = dummyItems.indexWhere((item) => item.id == houseId);
      emit(
        MyRoomLoaded(room: dummyRooms[index], house: dummyItems[index1]),
      );
    });
  }
}

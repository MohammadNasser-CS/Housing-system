import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/models/house_model.dart';
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

      final index1 = dummyItems.indexWhere(
          (item) => item.ownerName == dummyBedRooms[index].houseOwnerName);
      emit(
        MyRoomLoaded(room: dummyBedRooms[index], house: dummyItems[index1]),
      );
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/models/house_model.dart';

part 'add_new_house_state.dart';

class AddNewHouseCubit extends Cubit<AddNewHouseState> {
  AddNewHouseCubit() : super(AddNewHouseInitial());

  Future<void> addNewHouse(HouseModel newHouse) async {
    emit(AddNewHouseLoading());
    Future.delayed(const Duration(seconds: 2), () {
      dummyItems.add(newHouse);
      emit(
        AddNewHouseDoneSuccess(house: newHouse),
      );
    });
  }
}

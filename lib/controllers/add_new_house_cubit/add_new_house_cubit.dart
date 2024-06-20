import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/auth_exceptions.dart';
import 'package:housing_project/models/houses_models/house_model.dart';
import 'package:housing_project/models/houses_models/requestModels/house_request_model.dart';
import 'package:housing_project/services/house_owner_services/house_owner_services.dart';

part 'add_new_house_state.dart';

class AddNewHouseCubit extends Cubit<AddNewHouseState> {
  AddNewHouseCubit() : super(AddNewHouseInitial());
  final HouseOwnerServices _houseOwnerServices =
      HouseOwnerServicesImplementation();
  Future<void> addNewHouse(HouseRequestModel newHouseModel) async {
    try {
      String message = await _houseOwnerServices.addNewHouse(newHouseModel);
      emit(AddNewHouseSuccess(message: message));
    } on AuthException catch (exp) {
      emit(AddNewHouseError(message: exp.message));
    } catch (exp) {
      emit(AddNewHouseError(message: exp.toString()));
    }
  }
  
}

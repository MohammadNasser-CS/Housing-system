import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/auth_exceptions.dart';
import 'package:housing_project/models/houses_models/house_model.dart';
import 'package:housing_project/services/student_services/student_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final StudentServices _studentServices = StudentServicesImplementation();
  Future<void> getFavoriteHouses() async {
    try {
      emit(FavoriteLoading());
      final houses = await _studentServices.getFavoriteHouses();
      emit(FavoriteLoaded(houses: houses));
    } on AuthException catch (exp) {
      emit(FavoriteError(message: exp.message));
    } catch (exp) {
      emit(FavoriteError(message: exp.toString()));
    }
  }

 Future<void> changeFavorite(String houseId) async {
    try {
      emit(FavoriteLoading());
      String message = await _studentServices.changeFavorite(houseId);
      emit(FavroiteChangedSuccess(message: message));
      getFavoriteHouses();
    } on AuthException catch (exp) {
      emit(FavoriteError(message: exp.message));
    } catch (exp) {
      emit(FavoriteError(message: exp.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/auth_exceptions.dart';
import 'package:housing_project/models/home_category_model.dart';

import 'package:housing_project/models/houses_models/house_model.dart';
import 'package:housing_project/services/student_services/student_service.dart';

part 'user_home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final StudentServices _studentServices = StudentServicesImplementation();
  Future<void> getHomeData() async {
    try {
      emit(HomeLoading());
      final houses = await _studentServices.getAllHouses();
      emit(HomeLoaded(houses: houses));
    } on AuthException catch (exp) {
      emit(HomeError(message: exp.message));
    } catch (exp) {
      emit(HomeError(message: exp.toString()));
    }
  }

  Future<void> changeCategory(int? selectedCategoryIndex) async {
    try {
      emit(HomePageCategoryChanged(
          selectedCategoryIndex: selectedCategoryIndex));
      if (selectedCategoryIndex == null) {
        getHomeData();
      } else {
        emit(HomeLoading());
        String selectedCategory = categories[selectedCategoryIndex].category;
        final houses =
            await _studentServices.getCategorizedHouses(selectedCategory);
        emit(HomeLoaded(houses: houses));
      }
    } on AuthException catch (exp) {
      emit(HomeError(message: exp.message));
    } catch (exp) {
      emit(HomeError(message: exp.toString()));
    }
  }

  Future<void> searchFilled(String ownerName) async {
    try {
      emit(HomePageCategoryChanged(selectedCategoryIndex: null));
      emit(HomeLoading());
      final houses = await _studentServices.searchForSpecificOwner(ownerName);
      emit(HomeLoaded(houses: houses));
    } on AuthException catch (exp) {
      emit(HomeError(message: exp.message));
    } catch (exp) {
      emit(HomeError(message: exp.toString()));
    }
  }

  Future<void> changeFavorite(String houseId) async {
    try {
      emit(HomeLoading());
      String message = await _studentServices.changeFavorite(houseId);
      emit(FavroiteChangedSuccess(message: message));
      getHomeData();
    } on AuthException catch (exp) {
      emit(HomeError(message: exp.message));
    } catch (exp) {
      emit(HomeError(message: exp.toString()));
    }
  }
}

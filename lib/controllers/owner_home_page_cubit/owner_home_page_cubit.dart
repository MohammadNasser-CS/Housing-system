import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/auth_exceptions.dart';
import 'package:housing_project/models/houses_models/house_model.dart';
import 'package:housing_project/models/owner_room_requests_model.dart';
import 'package:housing_project/services/house_owner_services/house_owner_services.dart';

part 'owner_home_page_state.dart';

class OwnerHomePageCubit extends Cubit<OwnerHomePageState> {
  OwnerHomePageCubit() : super(OwnerHomePageInitial());
  final HouseOwnerServices _houseOwnerServices =
      HouseOwnerServicesImplementation();
  Future<void> getRequestsData() async {
    emit(OwnerHomePageLoading());
    // List<OwnerRoomRequestsModel> myRequests = dummyOwnerRoomRequests
    //     .where((element) => element.ownerToken == user.token)
    //     .toList();
    // await Future.delayed(
    //   const Duration(seconds: 2),
    //   () {
    //     emit(
    //       OwnerHomeRequestsLoaded(
    //         request: myRequests,
    //         // carouselItems: dummyCarouselItems,
    //       ),
    //     );
    //   },
    // );
  }

  Future<void> getHomeData() async {
    try {
      emit(OwnerHomePageLoading());
      final houses = await _houseOwnerServices.getAllHousesHouseOwner();
      emit(OwnerHomePageLoaded(houses: houses));
    } on AuthException catch (exp) {
      emit(OwnerHomePageError(message: exp.message));
    } catch (exp) {
      emit(OwnerHomePageError(message: exp.toString()));
    }
  }

  Future<void> searchFilled(String houseId) async {
    try {
      emit(OwnerHomePageLoading());
      final houses = await _houseOwnerServices.searchForSpecificHouse(houseId);
      emit(OwnerHomePageLoaded(houses: houses));
    } on AuthException catch (exp) {
      emit(OwnerHomePageError(message: exp.message));
    } catch (exp) {
      emit(OwnerHomePageError(message: exp.toString()));
    }
  }

  void chaneTapView() {
    emit(OwnerHomePageLoading());
    emit(const TapViewChanged());
  }

  // void changeCategory(int? selectedCategoryIndex) async {
  //   if (selectedCategoryIndex == null) {
  //     emit(const OwnerHomePageCategoryChanged());
  //     // debugPrint(filterdHouses.toString());
  //     // debugPrint('========================================');
  //     // debugPrint(dummyItems.toString());
  //     filterdHouses = dummyItems;
  //     emit(OwnerHomePageLoaded(houses: filterdHouses));
  //   } else {
  //     final selectedCategory = dummyCategories[selectedCategoryIndex];
  //     filterdHouses = dummyItems
  //         .where((element) => element.category == selectedCategory.category)
  //         .toList();
  //     emit(const OwnerHomePageCategoryChanged());
  //     emit(OwnerHomePageLoaded(houses: filterdHouses));
  //   }
  // }
}

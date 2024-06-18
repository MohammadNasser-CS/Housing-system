import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/models/houses_models/house_model.dart';
import 'package:housing_project/models/owner_room_requests_model.dart';
import 'package:housing_project/models/user_model.dart';

part 'owner_home_page_state.dart';

class OwnerHomePageCubit extends Cubit<OwnerHomePageState> {
  OwnerHomePageCubit() : super(OwnerHomePageInitial());
  Future<void> getRequestsData(UserModel user) async {
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

  Future<void> getHomeData(UserModel user) async {
    emit(OwnerHomePageLoading());
    // final products = await _homeServices.getProducts();
    List<HouseModel> myHouses =
        dummyItems.where((element) => element.ownerName == user.name).toList();
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        emit(
          OwnerHomePageLoaded(
            houses: myHouses,
            // carouselItems: dummyCarouselItems,
          ),
        );
      },
    );

    // final products = _homeServices.getProductsStream();
    // products.listen((event) {
    //   emit(
    //     HomeLoaded(
    //       products: event,
    //       carouselItems: dummyCarouselItems,
    //     ),
    //   );
    // });
  }

  void searchFilled(String houesNumber, UserModel user) {
    List<HouseModel> myHouses =
        dummyItems.where((element) => element.ownerName == user.name).toList();
    final List<HouseModel> filterdSearchHouses =
        myHouses.where((product) => product.houseId.contains(houesNumber)).toList();
    // debugPrint(filterdSearchHouses.toString());
    emit(OwnerHomePageLoaded(houses: filterdSearchHouses));
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

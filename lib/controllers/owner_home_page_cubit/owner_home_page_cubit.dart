import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/models/house_model.dart';
import 'package:housing_project/models/user_model.dart';

part 'owner_home_page_state.dart';

class OwnerHomePageCubit extends Cubit<OwnerHomePageState> {
  OwnerHomePageCubit() : super(OwnerHomePageInitial());

  Future<void> getHomeData(UserModel user) async {
    emit(OwnerHomePageLoading());
    // final products = await _homeServices.getProducts();
    List<HouseModel> myHouses =
        dummyItems.where((element) => element.ownerName == user.name).toList();
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        debugPrint('testtsetes');
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
  void searchFilled(String onwerName) {
    final List<HouseModel> filterdSearchHouses = filterdHouses
        .where((product) => product.ownerName.contains(onwerName))
        .toList();
    emit(OwnerHomePageLoaded(houses: filterdSearchHouses));
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

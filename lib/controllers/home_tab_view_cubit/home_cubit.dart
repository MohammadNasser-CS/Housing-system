import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/models/home_category_model.dart';

import 'package:housing_project/models/house_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  // final HomeServices _homeServices = HomeServicesImpl();
  Future<void> getHomeData() async {
    emit(HomeLoading());
    // final products = await _homeServices.getProducts();
    Future.delayed(const Duration(seconds: 2), () {
      emit(
        HomeLoaded(
          houses: filterdHouses,
          // carouselItems: dummyCarouselItems,
        ),
      );
    });

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

  void changeCategory(int? selectedCategoryIndex) async {
    if (selectedCategoryIndex == null) {
      emit(const HomePageCategoryChanged());
      filterdHouses = dummyItems;
      emit(HomeLoaded(houses: filterdHouses));
    } else {
      final selectedCategory = dummyCategories[selectedCategoryIndex];
      filterdHouses = dummyItems
          .where((element) => element.category == selectedCategory.category)
          .toList();
      emit(const HomePageCategoryChanged());
      emit(HomeLoaded(houses: filterdHouses));
    }
  }
// Future<void> addProduct(ProductItemModel product) async {
//     await _homeServices.addProduct(product);
//   }

//   Future<void> deleteProduct(String id) async {
//     await _homeServices.deleteProduct(id);
//   }

  void changeFavorite(String itemId) {
    final index = filterdHouses.indexWhere((item) => item.id == itemId);
    filterdHouses[index] = filterdHouses[index].copyWith(
      isFavorite: !filterdHouses[index].isFavorite,
    );
    final index1 = dummyItems.indexWhere((item) => item.id == itemId);
    dummyItems[index1] = dummyItems[index1].copyWith(
      isFavorite: !dummyItems[index1].isFavorite,
    );
    emit(
      HomeLoaded(
        houses: filterdHouses,
        // carouselItems: dummyCarouselItems,
      ),
    );
  }

  void searchFilled(String onwerName) {
    final List<HouseModel> filterdSearchHouses = filterdHouses
        .where((product) => product.ownerName.contains(onwerName))
        .toList();
    emit(HomeLoaded(houses: filterdSearchHouses));
  }
}

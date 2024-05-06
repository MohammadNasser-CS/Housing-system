import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:housing_project/models/house_modle.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  // final HomeServices _homeServices = HomeServicesImpl();
  Future<void> getHomeData() async {
    emit(HomeLoading());
    // final products = await _homeServices.getProducts();

    Future.delayed(const Duration(seconds: 3), () {
      emit(
        HomeLoaded(
          houses: dummyItems,
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
// Future<void> addProduct(ProductItemModel product) async {
//     await _homeServices.addProduct(product);
//   }

//   Future<void> deleteProduct(String id) async {
//     await _homeServices.deleteProduct(id);
//   }

  void changeFavorite(String itemId) {
    final index = dummyItems.indexWhere((item) => item.id == itemId);
    dummyItems[index] = dummyItems[index].copyWith(
      isFavorite: !dummyItems[index].isFavorite,
    );
    emit(
      HomeLoaded(
        houses: dummyItems,
        // carouselItems: dummyCarouselItems,
      ),
    );
  }
}

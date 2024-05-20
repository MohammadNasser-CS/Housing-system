import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/models/house_model.dart';

part 'house_details_state.dart';

class HouseDetailsCubit extends Cubit<HouseDetailsState> {
  HouseDetailsCubit() : super(HouseDetailsInitial());
  // final productDetailsServices = ProductDetailsServicesImpl();

  Future<void> getProductDetails(String id) async {
    emit(HouseDetailsLoading());
    Future.delayed(const Duration(seconds: 2), () {
      final index = dummyItems.indexWhere((item) => item.id == id);
      emit(
        HouseDetailsLoaded(house: dummyItems[index]),
      );
    });
    // final selectedProduct = await productDetailsServices.getProductDetails(id);
    // final index = dummyItems.indexWhere((item) => item.id == id);
    // emit(
    //   HouseDetailsLoaded(house: dummyItems[index]),
    // );
  }

  // void selectSize(ItemSize size) {
  //   selectedSize = size;
  //   emit(SizeSelected(size: size));
  // }

  Future<void> addToCart(String productId) async {
    emit(HouseAddingToCart());
    // try {
    //   final selectedProduct =
    //       await productDetailsServices.getProductDetails(productId);
    //   final cartItem = CartItemModel(
    //     id: selectedProduct.id,
    //     product: selectedProduct,
    //     size: selectedSize!,
    //     quantity: quantity,
    //   );
    //   await productDetailsServices.addToCart(cartItem);
    //   emit(
    //     ProductAddedToCart(productId: productId),
    //   );
    // } catch (e) {
    //   emit(
    //     ProductDetailsError(message: e.toString()),
    //   );
    // }
  }

  void changeFavorite(String itemId) {
    // final index = dummyItems.indexWhere((item) => item.id == itemId);
    // dummyItems[index] = dummyItems[index].copyWith(
    //   isFavorite: !dummyItems[index].isFavorite,
    // );
    final index1 = filterdHouses.indexWhere((item) => item.id == itemId);
    filterdHouses[index1] = filterdHouses[index1].copyWith(
      isFavorite: !filterdHouses[index1].isFavorite,
    );
    emit(
      HouseDetailsLoaded(house: filterdHouses[index1]),
    );
  }
}

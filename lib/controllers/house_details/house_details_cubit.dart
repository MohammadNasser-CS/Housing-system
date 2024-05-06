import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/models/house_modle.dart';

part 'house_details_state.dart';

class HouseDetailsCubit extends Cubit<HouseDetailsState> {
  HouseDetailsCubit() : super(HouseDetailsInitial());
  int quantity = 1;
  // final productDetailsServices = ProductDetailsServicesImpl();

  Future<void> getProductDetails(String id) async {
    emit(HouseDetailsLoading());
    // final selectedProduct = await productDetailsServices.getProductDetails(id);
    final index = dummyItems.indexWhere((item) => item.id == id);
    emit(
      HouseDetailsLoaded(house: dummyItems[index]),
    );
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

  void increment(String productId) {
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrement(String productId) {
    quantity--;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void changeFavorite(String itemId) {
    final index = dummyItems.indexWhere((item) => item.id == itemId);
    dummyItems[index] = dummyItems[index].copyWith(
      isFavorite: !dummyItems[index].isFavorite,
    );
    emit(
      HouseDetailsLoaded(house: dummyItems[index]),
    );
  }
}

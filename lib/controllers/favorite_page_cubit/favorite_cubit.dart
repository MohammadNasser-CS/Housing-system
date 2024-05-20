import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/models/house_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  void getFavoriteHouses() {
    emit(FavoriteLoading());
    Future.delayed(const Duration(seconds: 1), () {
      emit(FavoriteLoaded(
          houses:
              dummyItems.where((item) => item.isFavorite == true).toList()),);
    });
  }

  void changeFavorite(String itemId) {
    final index = dummyItems.indexWhere((item) => item.id == itemId);
    dummyItems[index] = dummyItems[index].copyWith(
      isFavorite: !dummyItems[index].isFavorite,
    );
    emit(
      FavoriteLoaded(
          houses:
              dummyItems.where((item) => item.isFavorite == true).toList()),
    );
  }
}

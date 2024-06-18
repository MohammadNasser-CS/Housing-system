part of 'user_home_cubit.dart';

sealed class HomeState {
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<HouseModel> houses;
  // final List<HomeCarouselModel> carouselItems;
   HomeLoaded({
    required this.houses,
    // required this.carouselItems,
  });
}

final class HomeError extends HomeState {
  final String message;
   HomeError({
    required this.message,
  });
}

final class FavroiteChangedSuccess extends HomeState {
  final String message;
   FavroiteChangedSuccess({required this.message});
}
final class HomePageCategoryChanged extends HomeState{
  final int ?selectedCategoryIndex;
   HomePageCategoryChanged({this.selectedCategoryIndex});
}
final class SearchFilled extends HomeState{
  // final List<HouseModel> filterdHouses;
   SearchFilled(/*{required this.filterdHouses}*/);
}
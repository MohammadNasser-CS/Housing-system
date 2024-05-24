part of 'user_home_cubit.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<HouseModel> houses;
  // final List<HomeCarouselModel> carouselItems;
  const HomeLoaded({
    required this.houses,
    // required this.carouselItems,
  });
}

final class HomeError extends HomeState {
  final String message;
  const HomeError({
    required this.message,
  });
}

final class HomePageFavroiteChangeLoaded extends HomeState {
  final List<HouseModel> houses;
  const HomePageFavroiteChangeLoaded({required this.houses});
}
final class HomePageCategoryChanged extends HomeState{
  // final List<HouseModel> filterdHouses;

  const HomePageCategoryChanged(/*{required this.filterdHouses}*/);
}
final class SearchFilled extends HomeState{
  // final List<HouseModel> filterdHouses;
  const SearchFilled(/*{required this.filterdHouses}*/);
}
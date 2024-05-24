part of 'owner_home_page_cubit.dart';

sealed class OwnerHomePageState {
  const OwnerHomePageState();
}

final class OwnerHomePageInitial extends OwnerHomePageState {}
final class HomeLoading extends OwnerHomePageState {}

final class OwnerHomePageLoaded extends OwnerHomePageState {
  final List<HouseModel> houses;
  // final List<HomeCarouselModel> carouselItems;
  const OwnerHomePageLoaded({
    required this.houses,
    // required this.carouselItems,
  });
}

final class OwnerHomePageError extends OwnerHomePageState {
  final String message;
  const OwnerHomePageError({
    required this.message,
  });
}


final class OwnerHomePageCategoryChanged extends OwnerHomePageState{
  // final List<HouseModel> filterdHouses;

  const OwnerHomePageCategoryChanged(/*{required this.filterdHouses}*/);
}
final class OwnerHomePageSearchFilled extends OwnerHomePageState{
  // final List<HouseModel> filterdHouses;
  const OwnerHomePageSearchFilled(/*{required this.filterdHouses}*/);
}
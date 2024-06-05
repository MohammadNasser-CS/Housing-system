part of 'owner_home_page_cubit.dart';

sealed class OwnerHomePageState {
  const OwnerHomePageState();
}

final class OwnerHomePageInitial extends OwnerHomePageState {}
final class OwnerHomePageLoading extends OwnerHomePageState {}

final class OwnerHomePageLoaded extends OwnerHomePageState {
  final List<HouseModel> houses;
  // final List<HomeCarouselModel> carouselItems;
  const OwnerHomePageLoaded({
    required this.houses,
    // required this.carouselItems,
  });
}
final class OwnerHomeRequestsLoaded extends OwnerHomePageState {
  final List<OwnerRoomRequestsModel> request;
  // final List<HomeCarouselModel> carouselItems;
  const OwnerHomeRequestsLoaded({
    required this.request,
    // required this.carouselItems,
  });
}

final class OwnerHomePageError extends OwnerHomePageState {
  final String message;
  const OwnerHomePageError({
    required this.message,
  });
}

final class TapViewChanged extends OwnerHomePageState{
  const TapViewChanged();
}


final class OwnerHomePageSearchFilled extends OwnerHomePageState{
  const OwnerHomePageSearchFilled();
}
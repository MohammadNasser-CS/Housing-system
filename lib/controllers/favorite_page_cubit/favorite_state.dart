part of 'favorite_cubit.dart';


sealed class FavoriteState {
  const FavoriteState();
}

final class FavoriteInitial extends FavoriteState {}
final class FavoriteLoading extends FavoriteState {}
final class FavroiteChangeLoaded extends FavoriteState {
final List<HouseModel> houses;
  const FavroiteChangeLoaded({
    required this.houses,
  });
}
final class FavroiteChangedSuccess extends FavoriteState {
  final String message;
   FavroiteChangedSuccess({required this.message});
}
final class FavoriteLoaded extends FavoriteState {
  final List<HouseModel> houses;
  const FavoriteLoaded({required this.houses});
}

final class FavoriteError extends FavoriteState {
  final String message;
  const FavoriteError({
    required this.message,
  });
}
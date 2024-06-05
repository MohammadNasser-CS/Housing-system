part of 'calender_select_cubit.dart';

sealed class CalenderSelectState {
  const CalenderSelectState();
}

final class CalenderSelectInitial extends CalenderSelectState {

}
final class CalenderSelectLoading extends CalenderSelectState {}

final class CalenderSelectLoaded extends CalenderSelectState {
  List<OwnerFreeDateTimeModel> days;
   CalenderSelectLoaded({required this.days});
}
final class DayIncludedStatusChanged extends CalenderSelectState{
   OwnerFreeDateTimeModel day;
   DayIncludedStatusChanged({required this.day});
}
final class DayListLoading extends CalenderSelectState{
   const DayListLoading();
}
final class CalenderSelectError extends CalenderSelectState {
  final String message;
  const CalenderSelectError({
    required this.message,
  });
}
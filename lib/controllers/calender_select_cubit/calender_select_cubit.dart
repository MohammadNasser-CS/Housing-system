import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/models/owner_free_date_time_model.dart';

part 'calender_select_state.dart';

class CalenderSelectCubit extends Cubit<CalenderSelectState> {
  CalenderSelectCubit() : super(CalenderSelectInitial());
  void startDateUpdated(String dateTimeSlotId,String newStartTime){
   final index =
        days.indexWhere((item) => item.dateTimeSlotId == dateTimeSlotId);
    days[index] = days[index].copyWith(
      startTime: newStartTime,
    );
    emit(DayIncludedStatusChanged(day: days[index]));
  }
   void endDateUpdated(String dateTimeSlotId,String newEndTime){
   final index =
        days.indexWhere((item) => item.dateTimeSlotId == dateTimeSlotId);
    days[index] = days[index].copyWith(
      endTime: newEndTime,
    );
    emit(DayIncludedStatusChanged(day: days[index]));
  }
   void changeDayIncludedStatus(String dateTimeSlotId) {
    final index =
        days.indexWhere((item) => item.dateTimeSlotId == dateTimeSlotId);
    days[index] = days[index].copyWith(
      included: !days[index].included,
    );
    emit(DayIncludedStatusChanged(day: days[index]));
  }
}

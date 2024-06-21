import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/auth_exceptions.dart';
import 'package:housing_project/models/owner_free_date_time_model.dart';
import 'package:housing_project/services/house_owner_services/house_owner_services.dart';

part 'calender_select_state.dart';

class CalenderSelectCubit extends Cubit<CalenderSelectState> {
  CalenderSelectCubit() : super(CalenderSelectInitial());

  final HouseOwnerServices _houseOwnerServices =
      HouseOwnerServicesImplementation();
  Future<void> addtimeSlotsAvailable(List<Map<String, String?>> times) async {
    try {
      emit(CalenderSelectLoading());
      String message = await _houseOwnerServices.addtimeSlotsAvailable(times);
      emit(AddtimeSlotsAvailableDone(message: message));
    } on AuthException catch (exp) {
      emit(CalenderSelectError(message: exp.message));
    } catch (exp) {
      emit(CalenderSelectError(message: exp.toString()));
    }
  }

  void startDateUpdated(String dateTimeSlotId, String newStartTime) {
    final index =
        days.indexWhere((item) => item.dateTimeSlotId == dateTimeSlotId);
    days[index] = days[index].copyWith(
      startTime: newStartTime,
      endTime: days[index].endTime,
    );
    emit(DayIncludedStatusChanged(day: days[index]));
  }

  void endDateUpdated(String dateTimeSlotId, String newEndTime) {
    final index =
        days.indexWhere((item) => item.dateTimeSlotId == dateTimeSlotId);
    days[index] = days[index].copyWith(
      endTime: newEndTime,
      startTime: days[index].startTime,
    );
    emit(DayIncludedStatusChanged(day: days[index]));
  }

  void changeDayIncludedStatus(String dateTimeSlotId) {
    final index =
        days.indexWhere((item) => item.dateTimeSlotId == dateTimeSlotId);
    days[index] = days[index].copyWith(
      included: !days[index].included,
      startTime: null,
      endTime: null,
    );
    emit(DayIncludedStatusChanged(day: days[index]));
  }
}

import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/calender_select_cubit/calender_select_cubit.dart';
import 'package:housing_project/models/owner_free_date_time_model.dart';
import 'package:housing_project/views/pages/owner_pages/owner_home_page/widgets/search_section_widgets/day_slot_card_widger.dart';

class FreeDateTimeSlotDialog extends StatefulWidget {
  const FreeDateTimeSlotDialog({super.key});

  @override
  State<FreeDateTimeSlotDialog> createState() => _FreeDateTimeSlotDialogState();
}

class _FreeDateTimeSlotDialogState extends State<FreeDateTimeSlotDialog> {
  final controller = BoardDateTimeController();
  // DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CalenderSelectCubit>(context);
    return BlocListener<CalenderSelectCubit, CalenderSelectState>(
      listenWhen: (previous, current) =>
          current is AddtimeSlotsAvailableDone ||
          current is CalenderSelectError,
      listener: (context, state) {
        if (state is AddtimeSlotsAvailableDone) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ),
          );
          Navigator.of(context).pop(context);
        } else if (state is CalenderSelectError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      }, //
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<CalenderSelectCubit, CalenderSelectState>(
              bloc: cubit,
              buildWhen: (previous, current) =>
                  current is DayIncludedStatusChanged,
              builder: (context, state) {
                return ListView.builder(
                  itemCount: days.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Column(
                    children: [
                      DaySlotCard(day: days[index]),
                      const Divider(
                        color: AppColor.black,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    bool anyDayWithoutTimes = days.any((day) =>
                        day.included &&
                        (day.startTime == null || day.endTime == null));
                    if (anyDayWithoutTimes) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'تأكد من تحديد ساعة البداية والنهاية لجميع الأيام التي اخترتها'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    } else {
                      List<Map<String, String?>> filteredDays = days
                          .where((day) => day.included)
                          .map((day) => {
                                'dayName': day.dayName,
                                'startTime': day.startTime,
                                'endTime': day.endTime,
                              })
                          .toList();
                      if (filteredDays.isNotEmpty) {
                        cubit.addtimeSlotsAvailable(filteredDays);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('لم تقم بتحديد أي أيام أو مواعيد'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        Navigator.of(context).pop(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12.0),
                    backgroundColor: AppColor.orange8,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('تأكيد المواعيد'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

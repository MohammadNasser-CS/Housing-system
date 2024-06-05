import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/calender_select_cubit/calender_select_cubit.dart';
import 'package:housing_project/models/owner_free_date_time_model.dart';
import 'package:housing_project/views/pages/owner_home_page/widgets/day_slot_card_widger.dart';

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
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.55,
      decoration: BoxDecoration(
        color: AppColor.grey1,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
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
                    // Navigator.of(context)
                    //     .pushNamed(AppRoutes.ordersPage)
                    //     .then((value) => Navigator.of(context).pop(context));
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

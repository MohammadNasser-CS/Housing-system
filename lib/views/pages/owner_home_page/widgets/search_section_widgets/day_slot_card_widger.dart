import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/calender_select_cubit/calender_select_cubit.dart';
import 'package:housing_project/models/owner_free_date_time_model.dart';

class DaySlotCard extends StatelessWidget {
  final OwnerFreeDateTimeModel day;

  const DaySlotCard({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CalenderSelectCubit>(context);
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsetsDirectional.only(bottom: 8.0, top: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: AppColor.black),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${day.dayName} :',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    InkWell(
                      onTap: () {
                        debugPrint('test');
                        cubit.changeDayIncludedStatus(day.dateTimeSlotId);
                        // setState(() {
                        //   day.included = !day.included;
                        // });
                      },
                      child: Container(
                        padding: const EdgeInsetsDirectional.all(4.0),
                        decoration: BoxDecoration(
                          color: day.included ? AppColor.green : AppColor.red,
                          shape: BoxShape.rectangle,
                        ),
                        child: Icon(
                          day.included
                              ? FontAwesomeIcons.check
                              : FontAwesomeIcons.x,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                day.included
                    ? Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final result = await showTimePicker(
                                  builder: (context, child) => Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        // change the border color
                                        primary: AppColor.teal3,
                                        // change the text color
                                        onSurface: AppColor.black,
                                        secondary: AppColor.teal3,
                                      ),
                                      // button colors
                                    ),
                                    child: child!,
                                  ),
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode:
                                      TimePickerEntryMode.dialOnly,
                                  context: context,
                                  helpText: 'إختر نطاق وقت الفراغ الخاص بك',
                                );
                                if (result != null) {
                                  DateTime now = DateTime.now();
                                  DateTime selectedDateTime = DateTime(
                                      now.year,
                                      now.month,
                                      now.day,
                                      result.hour,
                                      result.minute);
                                  String formattedTime =
                                      BoardDateFormat('hh:mm')
                                          .format(selectedDateTime);
                                  String amPm = selectedDateTime.hour >= 12
                                      ? '$formattedTime م'
                                      : '$formattedTime ص';
                                  cubit.startDateUpdated(
                                      day.dateTimeSlotId, amPm);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsetsDirectional.only(
                                    bottom: 8.0),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: AppColor.teal.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(color: AppColor.teal),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(FontAwesomeIcons.calendarMinus),
                                    Text(
                                      day.startTime ?? 'إختر ساعة البداية',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final result = await showTimePicker(
                                  builder: (context, child) => Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        // change the border color
                                        primary: AppColor.teal3,
                                        // change the text color
                                        onSurface: AppColor.black,
                                        secondary: AppColor.teal3,
                                      ),
                                      // button colors
                                    ),
                                    child: child!,
                                  ),
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode:
                                      TimePickerEntryMode.dialOnly,
                                  context: context,
                                  helpText: 'إختر نطاق وقت الفراغ الخاص بك',
                                );

                                if (result != null) {
                                  DateTime now = DateTime.now();
                                  DateTime selectedDateTime = DateTime(
                                      now.year,
                                      now.month,
                                      now.day,
                                      result.hour,
                                      result.minute);
                                  String formattedTime =
                                      BoardDateFormat('hh:mm')
                                          .format(selectedDateTime);
                                  String amPm = selectedDateTime.hour >= 12
                                      ? '$formattedTime م'
                                      : '$formattedTime ص';
                                  cubit.endDateUpdated(
                                      day.dateTimeSlotId, amPm);
                                }
                              },
                              child: Container(
                                margin: const EdgeInsetsDirectional.only(
                                    bottom: 8.0),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: AppColor.teal.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(color: AppColor.teal),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(FontAwesomeIcons.calendarPlus),
                                    Text(
                                      day.endTime ?? 'إختر ساعة النهاية',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

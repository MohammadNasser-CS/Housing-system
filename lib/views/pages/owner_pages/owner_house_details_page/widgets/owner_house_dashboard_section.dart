import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/owner_house_details_cubit/owner_house_details_cubit.dart';
import 'package:housing_project/views/pages/shared_pages/widgets/text_widget.dart';

class OwnerHouseDashboardSection extends StatefulWidget {
  final String roomId;
  final String studentName;
  final String phoneNumber;
  final String reservationEnd;
  final String reservationType;
  final String studentId;
  final String houseId;
  const OwnerHouseDashboardSection({
    super.key,
    required this.roomId,
    required this.studentId,
    required this.studentName,
    required this.phoneNumber,
    required this.reservationEnd,
    required this.reservationType,
    required this.houseId,
  });

  @override
  State<OwnerHouseDashboardSection> createState() =>
      _OwnerHouseDashboardSectionState();
}

class _OwnerHouseDashboardSectionState extends State<OwnerHouseDashboardSection>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  DateTime? endDateTime;

  Future<void> _showPhotoDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final dateResult = await showBoardDateTimePickerForDate(
                          useSafeArea: true,
                          useRootNavigator: true,
                          options: BoardDateTimeOptions(
                            weekend: const BoardPickerWeekendOptions(),
                            textColor: AppColor.black,
                            backgroundColor: AppColor.grey3,
                            activeTextColor: AppColor.black,
                            foregroundColor: AppColor.white,
                            pickerFormat: PickerFormat.dmy,
                            pickerSubTitles: const BoardDateTimeItemTitles(
                              year: 'السنة',
                              month: 'الشهر',
                              day: 'اليوم',
                            ),
                            showDateButton: false,
                            boardTitle:
                                'إختر التاريخ الذي تريد تمديد الحجز له. يمكنك الكتابة في كل حقل',
                          ),
                          context: context,
                        );
                        if (dateResult != null) {
                          setState(() {
                            endDateTime = dateResult;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsetsDirectional.all(16.0),
                        backgroundColor: AppColor.white,
                        surfaceTintColor: AppColor.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: AppColor.grey4),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          endDateTime == null
                              ? 'إختر تاريخ التمديد'
                              : BoardDateFormat('yyyy-MM-dd')
                                  .format(endDateTime!),
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.grey7,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop('confirmed');
                            },
                            child: Container(
                              padding: const EdgeInsetsDirectional.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.blue),
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Center(
                                child: Text(
                                  'تأكيد',
                                  style: TextStyle(color: AppColor.blue),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                endDateTime = null;
                              });
                              Navigator.of(context).pop('cancelled');
                            },
                            child: Container(
                              padding: const EdgeInsetsDirectional.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.red),
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Center(
                                child: Text(
                                  'إلغاء',
                                  style: TextStyle(color: AppColor.red),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    // Check the result when the dialog is dismissed
    if (result == null) {
      setState(() {
        endDateTime = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OwnerHouseDetailsCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(title: 'رقم الغرفة: ', value: widget.roomId),
            TextWidget(title: 'اسم الطالب: ', value: widget.studentName),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(title: 'رقم الهاتف: ', value: widget.phoneNumber),
            TextWidget(
                title: 'تاريخ انتهاء الحجز: ', value: widget.reservationEnd),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(title: 'نوع الحجز: ', value: widget.reservationType),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    await cubit.finishRoomReservation(
                        widget.studentId, widget.houseId);
                  },
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(4.0),
                    decoration: BoxDecoration(
                        color: AppColor.red6,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: const Text(
                      'إنهاء الحجز',
                      style: TextStyle(
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4.0),
                InkWell(
                  onTap: () async {
                    await _showPhotoDialog();
                    debugPrint(endDateTime.toString());
                    if (endDateTime != null) {
                      await cubit.updateRoomReservation({
                        'studentId': widget.studentId,
                        'reservationEnd':
                            BoardDateFormat('yyyy-MM-dd').format(endDateTime!),
                      }, widget.houseId);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(4.0),
                    decoration: BoxDecoration(
                        color: AppColor.blue,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: const Text(
                      'تجديد الحجز',
                      style: TextStyle(
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}

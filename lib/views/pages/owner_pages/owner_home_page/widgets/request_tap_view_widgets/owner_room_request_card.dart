import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/owner_home_page_cubit/owner_home_page_cubit.dart';
import 'package:housing_project/models/room_requests_model.dart';
import 'package:housing_project/views/pages/shared_pages/widgets/text_widget.dart';

class OwnerRoomRequestCard extends StatefulWidget {
  final RoomRequestsModel roomRequestsModel;
  const OwnerRoomRequestCard({super.key, required this.roomRequestsModel});

  @override
  State<OwnerRoomRequestCard> createState() => _OwnerRoomRequestCardState();
}

class _OwnerRoomRequestCardState extends State<OwnerRoomRequestCard>
    with SingleTickerProviderStateMixin {
  DateTime? startDateTime, endDateTime;
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

  Future<void> _showPhotoDialog() async {
    final result = await showDialog(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final result = await showBoardDateTimePickerForDate(
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
                                    'إختر تاريخ ميلادك، يمكنك الكتابة في كل حقل',
                              ),
                              context: context,
                            );
                            if (result != null) {
                              setState(() {
                                startDateTime = result;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsetsDirectional.all(16.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.green),
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                startDateTime == null
                                    ? 'إختر تاريخ البداية'
                                    : BoardDateFormat('yyyy-MM-dd')
                                        .format(startDateTime!),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.grey7,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final result = await showBoardDateTimePickerForDate(
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
                                    'إختر تاريخ ميلادك، يمكنك الكتابة في كل حقل',
                              ),
                              context: context,
                            );
                            if (result != null) {
                              setState(() {
                                endDateTime = result;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsetsDirectional.all(16.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.green),
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                endDateTime == null
                                    ? 'إختر تاريخ النهاية'
                                    : BoardDateFormat('yyyy-MM-dd')
                                        .format(endDateTime!),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.grey7,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                            startDateTime = endDateTime = null;
                            Navigator.of(context).pop('cancalled');
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
        });
      },
    );
    // Check the result when the dialog is dismissed
    if (result == null) {
      setState(() {
        endDateTime = startDateTime = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OwnerHomePageCubit>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsetsDirectional.all(8.0),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.grey4),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      title: 'إسم الطالب: ',
                      value: widget.roomRequestsModel.studentName!),
                  SizedBox(height: size.height * 0.02),
                  TextWidget(
                      title: 'رقم الهاتف: ',
                      value: widget.roomRequestsModel.studentPhoneNumber!),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 24.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: AppColor.grey1,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColor.grey4),
                    ),
                    child: Text(
                      widget.roomRequestsModel.selectedDateTimeSlot!,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: size.height * 0.02),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColor.white,
                    border: Border.all(
                      color: AppColor.grey4,
                    ),
                  ),
                  child: Row(
                    children: [
                      TextWidget(
                        title: 'رقم الشقة: ',
                        value: widget.roomRequestsModel.houseId,
                      ),
                      VerticalDivider(
                        color: AppColor.orange8,
                        thickness: 1.0,
                      ),
                      TextWidget(
                        title: 'رقم الغرفة: ',
                        value: widget.roomRequestsModel.roomId,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsetsDirectional.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: widget.roomRequestsModel.requestStatus ==
                            'في الإنتظار'
                        ? AppColor.green1
                        : widget.roomRequestsModel.requestStatus == 'تم التأكيد'
                            ? AppColor.teal
                            : AppColor.green,
                    border: Border.all(
                      color: AppColor.grey4,
                    ),
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'حالة الطلب: ',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: AppColor.black),
                        ),
                        TextSpan(
                          text: widget.roomRequestsModel.requestStatus,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                      AppColor.red,
                    ),
                  ),
                  onPressed: () async {
                    await cubit.rejectRequestHouseOwenr(
                        widget.roomRequestsModel.requestId);
                  },
                  child: Text(
                    'رفض الطلب',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                      AppColor.green,
                    ),
                  ),
                  onPressed: () async {
                    if (widget.roomRequestsModel.requestStatus ==
                        'في الإنتظار') {
                      await cubit.confirmAppointment(
                          widget.roomRequestsModel.requestId);
                    } else if (widget.roomRequestsModel.requestStatus ==
                        'تم التأكيد') {
                      await _showPhotoDialog();
                      if (startDateTime != null && endDateTime != null) {
                        await cubit.acceptRoomReservationRequest({
                          'requestId': widget.roomRequestsModel.requestId,
                          'reservationDate': BoardDateFormat('yyyy-MM-dd')
                              .format(startDateTime!),
                          'reservationEnd': BoardDateFormat('yyyy-MM-dd')
                              .format(endDateTime!),
                          'reservationType': 'غرفة',
                        });
                      } else {}
                    }
                  },
                  child: Text(
                    widget.roomRequestsModel.requestStatus == 'في الإنتظار'
                        ? 'قبول موعد للقاء'
                        : 'قبول حجز الغرفة',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

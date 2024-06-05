import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/my_room_page_cubit/my_room_cubit.dart';
import 'package:housing_project/models/room_requests_model.dart';
import 'package:housing_project/views/pages/my_room_page/widgets/date_time_dialog.dart';
import 'package:housing_project/views/widgets/text_widget.dart';

class RoomRequestCard extends StatefulWidget {
  final StudentRoomRequestsModel roomRequestsModel;
  final String? date;
  const RoomRequestCard(
      {super.key, required this.roomRequestsModel, this.date});

  @override
  State<RoomRequestCard> createState() => _RoomRequestCardState();
}

class _RoomRequestCardState extends State<RoomRequestCard>
    with SingleTickerProviderStateMixin {
  String? dateTime;

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

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MyRoomCubit>(context);
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
                      title: 'إسم صاحب السكن: ',
                      value: widget.roomRequestsModel.houseOwnerName),
                  SizedBox(height: size.height * 0.02),
                  TextWidget(
                      title: 'رقم الهاتف: ',
                      value: widget.roomRequestsModel.ownerPhoneNumber),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 8.0),
                  BlocBuilder<MyRoomCubit, MyRoomState>(
                    bloc: cubit,
                    buildWhen: (previous, current) =>
                        (current is DayTimeSlotChanged &&
                            current.requestId ==
                                widget.roomRequestsModel.requestId) ||
                        current is RoomRequestsLoaded,
                    builder: (context, state) {
                      if (state is DayTimeSlotChanged) {
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useRootNavigator: true,
                              useSafeArea: true,
                              showDragHandle: true,
                              enableDrag: true,
                              builder: (BuildContext context) {
                                return BottomSheet(
                                  backgroundColor: AppColor.white,
                                  onClosing: () {},
                                  animationController: _animationController,
                                  builder: (context) => StatefulBuilder(
                                    builder: (context, setState) =>
                                        BlocProvider.value(
                                      value: cubit,
                                      child: DateTimeSlotDialog(
                                        dateTimeSlots: widget
                                            .roomRequestsModel.dateTimeSlots,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).then((value) {
                              debugPrint('test');
                              if (value != null) {
                                cubit.selectDateTimeSlot(
                                    value, widget.roomRequestsModel.requestId);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 24.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: AppColor.grey1,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: AppColor.grey4),
                            ),
                            child: Text(
                              state.newDateTime,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                          ),
                        );
                      } else if (state is RoomRequestsLoaded) {
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useRootNavigator: true,
                              useSafeArea: true,
                              showDragHandle: true,
                              enableDrag: true,
                              builder: (BuildContext context) {
                                return BottomSheet(
                                  backgroundColor: AppColor.white,
                                  onClosing: () {},
                                  animationController: _animationController,
                                  builder: (context) => StatefulBuilder(
                                    builder: (context, setState) =>
                                        BlocProvider.value(
                                      value: cubit,
                                      child: DateTimeSlotDialog(
                                        dateTimeSlots: widget
                                            .roomRequestsModel.dateTimeSlots,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).then((value) {
                              debugPrint('test');
                              if (value != null) {
                                cubit.selectDateTimeSlot(
                                    value, widget.roomRequestsModel.requestId);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 24.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: AppColor.grey1,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: AppColor.grey4),
                            ),
                            child: const Text('إختر موعد'),
                          ),
                        );
                      } else {
                        return SizedBox.fromSize();
                      }
                    },
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
                    color:
                        widget.roomRequestsModel.requestStatus == 'إختيار موعد'
                            ? AppColor.green1
                            : widget.roomRequestsModel.requestStatus ==
                                    'تم تحديد موعد'
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
                  onPressed: () {},
                  child: Text(
                    'إلغي طلب الحجز',
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
                  onPressed: () {},
                  child: Text(
                    'تأكيد موعد ',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
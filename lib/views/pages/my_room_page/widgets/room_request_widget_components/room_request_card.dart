import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/models/room_requests_model.dart';
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
              TextWidget(
                  title: 'إسم صاحب السكن: ',
                  value: widget.roomRequestsModel.houseOwnerName),
              SizedBox(height: size.height * 0.02),
              TextWidget(
                  title: 'رقم الهاتف: ',
                  value: widget.roomRequestsModel.ownerPhoneNumber),
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

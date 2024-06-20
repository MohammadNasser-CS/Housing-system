import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/models/houses_models/my_room_model.dart';
import 'package:housing_project/views/pages/house_details_page/widgets/contact_section.dart';
import 'package:housing_project/views/widgets/text_widget.dart';

class RoomItem extends StatefulWidget {
  final MyRoomModel room;
  const RoomItem({
    super.key,
    required this.room,
  });

  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  final controller = BoardDateTimeController();

  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsetsDirectional.only(bottom: size.width * 0.03),
      decoration: BoxDecoration(
        color: AppColor.grey2,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColor.orange8),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: widget.room.roomPhoto,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: size.height * 0.3,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator.adaptive()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(
            height: size.height * 0.2,
            decoration: BoxDecoration(
              color: AppColor.grey2,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                          title: 'مساحة الغرفة:',
                          value: ' ${widget.room.roomSpace} م\u00b2'),
                      TextWidget(
                          title: 'عدد الأسرَّة المتبقية:',
                          value: ' ${widget.room.availableBeds}'),
                      TextWidget(
                          title: 'تكلفة حجز الغرفة:',
                          value: ' ${widget.room.price} \u20AA '),
                    ],
                  ),
                  VerticalDivider(
                    color: AppColor.orange8,
                    thickness: 1.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                          title: 'يحتوي على مكيف؟:', value: widget.room.hasAc),
                      TextWidget(
                          title: 'يحتوي على مكتب للدراسة؟:',
                          value: widget.room.hasDesk),
                      TextWidget(
                        title: 'يحتوي على  بلكونة: ',
                        value: widget.room.hasBalcony,
                      ),
                      TextWidget(
                        title: 'ينتهي الحجز في تاريخ: ',
                        value: widget.room.reservationEnd,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(color: AppColor.orange8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
            child: ContactSection(
              ownerName: widget.room.houseOwnerName,
              phoneNumber: widget.room.houseOwnerPhone,
            ),
          ),
        ],
      ),
    );
  }
}

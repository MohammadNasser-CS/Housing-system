import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/models/house_model.dart';
import 'package:housing_project/models/rooms_model.dart';
import 'package:housing_project/views/pages/house_details_page/widgets/contact_section.dart';
import 'package:housing_project/views/pages/my_room_page/widgets/text_widget.dart';

class RoomItem extends StatelessWidget {
  final RoomModel room;
  final HouseModel house;
  final dynamic cubit;
  const RoomItem({
    super.key,
    required this.room,
    required this.house,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsetsDirectional.only(bottom: size.width * 0.02),
      decoration: BoxDecoration(
        color: AppColor.grey2,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColor.orange),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: CachedNetworkImage(
              imageUrl: room.imageUrl,
              fit: BoxFit.fitWidth,
              width: double.infinity,
              height: size.height * 0.3,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.grey2,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  title: 'مساحة الغرفة:',
                                  value: ' ${room.roomSpace}م\u00b2'),
                              TextWidget(
                                  title: 'عدد الأسرَّة المتبقية:',
                                  value: ' ${room.bedsNumber}'),
                              TextWidget(
                                  title: 'تكلفة حجز الغرفة:',
                                  value: ' ${room.roomPrice}\u20AA '),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  title: 'يحتوي على مكتب للدراسة؟:',
                                  value: room.hasOffice ? ' نعم' : ' لا'),
                              TextWidget(
                                title: 'السعر يشمل خدمة الكهرباء؟:',
                                value: room.electricityService ? ' نعم' : ' لا',
                              ),
                              TextWidget(
                                  title: 'السعر يشمل خدمة الماء؟:',
                                  value: room.waterService ? ' نعم' : ' لا'),
                              TextWidget(
                                  title: 'السعر يشمل خدمة الغاز؟:',
                                  value: room.gasService ? ' نعم' : ' لا'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: AppColor.orange),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
            child: ContactSection(ownerName: house.ownerName),
          ),
        ],
      ),
    );
  }
}

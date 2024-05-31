import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/models/house_model.dart';
import 'package:housing_project/models/rooms_model.dart';
import 'package:housing_project/views/pages/house_details_page/widgets/contact_section.dart';
import 'package:housing_project/views/pages/my_room_page/widgets/text_widget.dart';

class RoomItem extends StatefulWidget {
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
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  final controller = BoardDateTimeController();

  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsetsDirectional.all(4.0),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsetsDirectional.only(bottom: size.width * 0.02),
      decoration: BoxDecoration(
        color: AppColor.grey2,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColor.orange8),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: widget.room.imageUrl,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextWidget(
                          title: 'مساحة الغرفة:',
                          value: ' ${widget.room.roomSpace}م\u00b2'),
                      TextWidget(
                          title: 'يحتوي على مكتب للدراسة؟:',
                          value: widget.room.hasOffice ? ' نعم' : ' لا'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextWidget(
                          title: 'عدد الأسرَّة المتبقية:',
                          value: ' ${widget.room.bedsNumber}'),
                      TextWidget(
                          title: 'يحتوي على مكيف؟:',
                          value: widget.room.hasOffice ? ' نعم' : ' لا'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextWidget(
                          title: 'تكلفة حجز الغرفة:',
                          value: ' ${widget.room.roomPrice}\u20AA '),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(color: AppColor.orange8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
            child: ContactSection(ownerName: widget.house.ownerName),
          ),
          Divider(color: AppColor.orange8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: Text(
                    BoardDateFormat('yyyy-MM-dd – hh:mm').format(date),
                  ),
                  onPressed: () async {
                    // final result = await showTimePicker(
                    //     context: context, initialTime: TimeOfDay.now());
                    final result = await showBoardDateTimePicker(
                      useSafeArea: true,
                      useRootNavigator: true,
                      options: BoardDateTimeOptions(
                        textColor: AppColor.black,
                        backgroundColor: AppColor.grey3,
                        activeTextColor: AppColor.black,
                        foregroundColor: AppColor.white,
                        pickerSubTitles: const BoardDateTimeItemTitles(
                          year: 'السنة',
                          month: 'الشهر',
                          day: 'اليوم',
                          hour: 'الساعة',
                          minute: 'الدقيقة',
                        ),
                        customOptions: BoardPickerCustomOptions(
                          hours: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
                          minutes: [00, 30],
                        ),
                        showDateButton: false,
                        boardTitle: 'إختر تاريخ ووقت تكون به متفرغا',
                      ),
                      context: context,
                      pickerType: DateTimePickerType.datetime,
                    );
                    if (result != null) {
                      setState(() {
                        date = result;
                        BoardDateFormat dateFormat =
                            BoardDateFormat("yyyy-MM-dd HH:mm");
                        String test = dateFormat.format(date);
                        debugPrint(test);
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

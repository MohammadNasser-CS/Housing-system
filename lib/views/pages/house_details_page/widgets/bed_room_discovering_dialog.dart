import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/models/rooms_model.dart';
import 'package:housing_project/views/widgets/text_widget.dart';

class BedRoomDiscoveringDialog extends StatefulWidget {
  final BedRoomModel room;
  const BedRoomDiscoveringDialog({super.key, required this.room});

  @override
  State<BedRoomDiscoveringDialog> createState() =>
      _BedRoomDiscoveringDialogState();
}

class _BedRoomDiscoveringDialogState extends State<BedRoomDiscoveringDialog> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.topCenter,
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: widget.room.imagesUrl.map((imageUrl) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsetsDirectional.symmetric(
                        horizontal:
                            4.0), // Optional: add some margin between images
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: double.infinity,
                        height: size.height * 0.2,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: size.height * 0.01),
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
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.room.bedsNumber != 0
                          ? debugPrint('تم الحجز بنجاح')
                          : debugPrint('لا يوجد أسرة متبقة في الغرفة');
                      // Navigator.of(context)
                      //     .pushNamed(AppRoutes.ordersPage)
                      //     .then((value) => Navigator.of(context).pop(context));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.orange8,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text('إحجز الغرفة!'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

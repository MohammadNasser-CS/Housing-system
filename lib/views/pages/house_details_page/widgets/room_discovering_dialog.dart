import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/models/rooms_model.dart';

class RoomDiscoveringDialog extends StatefulWidget {
  final RoomModel room;
  const RoomDiscoveringDialog({super.key, required this.room});

  @override
  State<RoomDiscoveringDialog> createState() => _RoomDiscoveringDialogState();
}

class _RoomDiscoveringDialogState extends State<RoomDiscoveringDialog> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.8,
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
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.room.imageUrl,
                      // height: size.height * 0.06,
                      // width: double.infinity,
                      height: size.height * 0.2,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.01),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.room.imageUrl,
                      // height: size.height * 0.06,
                      // width: double.infinity,
                      height: size.height * 0.2,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.grey2,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    height: size.height * 0.2,
                    padding: EdgeInsetsDirectional.symmetric(
                        vertical: size.height * 0.02),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'مساحة الغرفة:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w900,
                                              color: AppColor.grey7),
                                    ),
                                    TextSpan(
                                      text: ' ${widget.room.roomSpace}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.black),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'عدد الأسرَّة المتبقية:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w900,
                                              color: AppColor.grey7),
                                    ),
                                    TextSpan(
                                      text: ' ${widget.room.bedsNumber}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.black),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'تكلفة حجز الغرفة:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w900,
                                              color: AppColor.grey7),
                                    ),
                                    TextSpan(
                                      text: ' 9999 شيقل',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'يحتوي على مكتب للدراسة؟:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w900,
                                              color: AppColor.grey7),
                                    ),
                                    TextSpan(
                                      text: widget.room.hasOffice
                                          ? ' نعم'
                                          : ' لا',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.black),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'يحتوي على مكيف للدراسة؟:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w900,
                                              color: AppColor.grey7),
                                    ),
                                    TextSpan(
                                      text: widget.room.hasOffice
                                          ? ' نعم'
                                          : ' لا',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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

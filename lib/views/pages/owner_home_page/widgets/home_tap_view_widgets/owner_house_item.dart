import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/models/house_model.dart';
import 'package:housing_project/views/widgets/text_widget.dart';

class OwnerHouseItem extends StatelessWidget {
  final HouseModel houseItemModel;
  final dynamic cubit;
  const OwnerHouseItem({
    super.key,
    required this.houseItemModel,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.35,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsetsDirectional.only(bottom: size.width * 0.03),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: AppColor.orange8),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: houseItemModel.imgUrl,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: size.height * 0.3,
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Positioned(
                      top: 3.0,
                      left: 3.0,
                      child: Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: AppColor.white,
                        ),
                        child: TextWidget(
                          title: 'نوع العقار: ',
                          value: houseItemModel.category,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.013,
                      vertical: size.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextWidget(
                              title: 'مالك السكن: ',
                              value: houseItemModel.ownerName),
                          TextWidget(
                              title: 'عدد الغرف المتاحة: ',
                              value: '${houseItemModel.freeRoomsNumber}'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.location_on_outlined,
                                      size: size.width * 0.03),
                                ),
                                TextSpan(
                                  text: houseItemModel.location,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.03,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.bed_outlined,
                                    size: size.width * 0.03,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' عدد غرف النوم : ${houseItemModel.roomsNumber}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.03,
                                      ),
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
            ],
          ),
        ),
      ],
    );
  }
}

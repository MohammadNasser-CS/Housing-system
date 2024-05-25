import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/models/house_model.dart';

class HouseItem extends StatelessWidget {
  final HouseModel houseItemModel;
  final dynamic cubit;
  const HouseItem({
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
          height: size.height * 0.45,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsetsDirectional.only(bottom: size.width * 0.02),
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
                      right: 3.0,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.black26,
                        ),
                        child: IconButton(
                          onPressed: () {
                            // debugPrint(houseItemModel.id);
                            cubit.changeFavorite(houseItemModel.id);
                          },
                          icon: Icon(
                            houseItemModel.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: AppColor.red,
                          ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'مالك السكن: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w900,
                                          fontSize: size.width * 0.03,
                                          color: AppColor.grey7),
                                ),
                                TextSpan(
                                  text: houseItemModel.ownerName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: size.width * 0.03,
                                          color: AppColor.black),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'عدد الغرف المتاحة: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w900,
                                          fontSize: size.width * 0.03,
                                          color: AppColor.grey7),
                                ),
                                TextSpan(
                                  text: '${houseItemModel.freeRoomsNumber}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: size.width * 0.03,
                                          color: AppColor.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
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
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.bathroom_outlined,
                                    size: size.width * 0.03,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' عدد الحمامات: ${houseItemModel.bathRoomsNumber}',
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

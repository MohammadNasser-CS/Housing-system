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
        Stack(
          children: [
            Container(
              height: size.height * 0.25,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.grey.shade200,
              ),
              child: CachedNetworkImage(
                imageUrl: houseItemModel.imgUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator.adaptive()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Positioned(
              top: 3.0,
              right: 3.0,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black26,
                ),
                child: IconButton(
                  onPressed: () {
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
        const SizedBox(height: 6.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    houseItemModel.ownerName,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
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
                                  fontSize: 16,
                                  color: AppColor.grey),
                        ),
                        TextSpan(
                          text: '${houseItemModel.freeRoomsNumber}',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColor.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(Icons.location_on_outlined, size: 16),
                    ),
                    TextSpan(
                      text: houseItemModel.location,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.bathroom_outlined,
                            size: 16,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' عدد الحمامات: ${houseItemModel.bathRoomsNumber}',
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.bed_outlined,
                            size: 16,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' عدد غرف النوم : ${houseItemModel.roomsNumber}',
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

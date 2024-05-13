
import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:readmore/readmore.dart';

class HouseDescriptionSection extends StatelessWidget {
  final int bathRoomsNumber;
  final int roomsNumber;
  final String description;
  const HouseDescriptionSection(
      {super.key,
      required this.bathRoomsNumber,
      required this.roomsNumber,
      required this.description});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المواصفات',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: size.height * 0.015),
        Row(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600, color: AppColor.grey7),
                    child: Icon(
                      Icons.bathroom_outlined,
                      color: AppColor.grey7,
                    ),
                  ),
                  TextSpan(
                    text: ' $bathRoomsNumber حمام',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.grey7,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(width: size.width * 0.06),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  WidgetSpan(
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600, color: AppColor.grey7),
                    child: Icon(
                      Icons.bed_outlined,
                      color: AppColor.grey7,
                    ),
                  ),
                  TextSpan(
                    text: ' $roomsNumber غرفة نوم',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600, color: AppColor.grey7),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.015),
        Text(
          'الوصف',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReadMoreText(
                colorClickableText: Theme.of(context).primaryColor,
                trimCollapsedText: 'المزيد',
                trimExpandedText: 'أقل',
                trimLines: 3,
                trimMode: TrimMode.Line,
                description,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColor.grey,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

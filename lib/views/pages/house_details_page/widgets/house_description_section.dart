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
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.06,
              ),
        ),
        SizedBox(height: size.height * 0.015),
        Row(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.bathroom_outlined,
                      size: size.width * 0.05,
                      color: AppColor.darkGrey,
                    ),
                  ),
                  TextSpan(
                    text: ' $bathRoomsNumber حمام',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.04,
                          color: AppColor.darkGrey,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(width: size.width * 0.06),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.bed_outlined,
                      size: size.width * 0.05,
                      color: AppColor.darkGrey,
                    ),
                  ),
                  TextSpan(
                    text: ' $roomsNumber غرفة نوم',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.04,
                        color: AppColor.darkGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.015),
        Text(
          'الوصف',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.06,
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
                style: TextStyle(
                  fontSize: size.width * 0.037,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

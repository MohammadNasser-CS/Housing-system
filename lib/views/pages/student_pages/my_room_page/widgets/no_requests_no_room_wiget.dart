import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_project/Utils/app_color.dart';

class NoHouseWidget extends StatelessWidget {
  final String title;
  const NoHouseWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.building,
            size: size.width * 0.2,
            color: AppColor.grey4,
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColor.grey4,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

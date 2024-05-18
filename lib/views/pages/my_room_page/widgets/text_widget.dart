import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final String value;
  const TextWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontWeight: FontWeight.w900, color: AppColor.grey7),
          ),
          TextSpan(
            text: value,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontWeight: FontWeight.w700, color: AppColor.black),
          ),
        ],
      ),
    );
  }
}

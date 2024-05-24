import 'package:flutter/material.dart';
import 'package:housing_project/views/pages/custom_bottom_navbar/widgets/title_value_widget.dart';

class AppBarTitleForOwner extends StatelessWidget {
  final int index;
  const AppBarTitleForOwner({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return index == 0
        ? const TitleValueWidget(text: 'عقاراتي')
        : index == 1
            ? const TitleValueWidget(text: 'الإشعارات')
            : index == 4
                ? const TitleValueWidget(text: 'الإعدادات')
                : const SizedBox.shrink();
  }
}

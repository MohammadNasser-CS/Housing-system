import 'package:flutter/material.dart';
import 'package:housing_project/views/pages/custom_bottom_navbar/widgets/title_value_widget.dart';

class AppBarTitleForUser extends StatelessWidget {
  final int index;
  const AppBarTitleForUser({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return index == 0
        ? const TitleValueWidget(text: 'الصفحة الرئيسية')
        : index == 1
            ? const TitleValueWidget(text: 'غرفتي')
            : index == 2
                ? const TitleValueWidget(text: 'الغرف المفضلة')
                : index == 3
                    ? const TitleValueWidget(text: 'الإشعارات')
                    : index == 4
                        ? const TitleValueWidget(text: 'الإعدادات')
                        : const SizedBox.shrink();
  }
}

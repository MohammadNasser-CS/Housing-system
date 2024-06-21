import 'package:flutter/material.dart';
import 'package:housing_project/views/pages/custom_bottom_navbar/widgets/title_value_widget.dart';

class AppBarTitleForAdmin extends StatelessWidget {
  final int index;
  const AppBarTitleForAdmin({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return index == 0
        ? const TitleValueWidget(text: 'طلبات تفعيل الحساب')
        : index == 1
            ? const TitleValueWidget(text: 'الإشعارات')
            : index == 2
                ? const TitleValueWidget(text: 'الإعدادات')
                : const SizedBox.shrink();
  }
}

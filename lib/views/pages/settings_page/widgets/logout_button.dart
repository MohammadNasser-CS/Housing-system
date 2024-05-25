import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/app_routes.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              debugPrint('tset');
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(AppRoutes.loginPage);
            },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsetsDirectional.symmetric(
                    vertical: size.width * 0.03),
                backgroundColor: AppColor.orange8,
                foregroundColor: AppColor.white),
            child: Text(
              'تسجيل الخروج',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

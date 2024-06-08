import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/routes/app_routes.dart';
import 'package:housing_project/models/user_model.dart';

class SettingsPageCard extends StatelessWidget {
  final UserModel user;
  final bool isChangePassword;
  const SettingsPageCard(
      {super.key, required this.user, this.isChangePassword = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
          color: AppColor.white, border: Border.all(color: AppColor.grey4)),
      child: ListTile(
        hoverColor: AppColor.orange4,
        leading: !isChangePassword
            ? Icon(
                FontAwesomeIcons.circleUser,
                size: size.width * 0.07,
              )
            : Icon(Icons.lock_outline, size: size.width * 0.07),
        title: !isChangePassword
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: AppColor.black),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: AppColor.grey),
                  ),
                ],
              )
            : Text(
                'تغيير كلمة المرور',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.black),
              ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          !isChangePassword
              ? Navigator.of(context, rootNavigator: true)
                  .pushNamed(AppRoutes.profilePage, arguments: user)
              : Navigator.of(context, rootNavigator: true)
                  .pushNamed(AppRoutes.changePasswordPage, arguments: user);
        },
      ),
    );
  }
}

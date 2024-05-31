import 'package:flutter/material.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/settings_page/widgets/logout_button.dart';
import 'package:housing_project/views/pages/settings_page/widgets/settings_page_card.dart';

class SettingsPage extends StatelessWidget {
  final UserModel user;
  const SettingsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02, horizontal: size.width * 0.02),
        child: Column(
          children: [
            SettingsPageCard(user: user),
            SizedBox(height: size.height * 0.02),
            SettingsPageCard(
              user: user,
              isChangePassword: true,
            ),
            const Spacer(),
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}

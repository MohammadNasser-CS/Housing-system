import 'package:flutter/material.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/settings_page/widgets/logout_button.dart';
import 'package:housing_project/views/pages/settings_page/widgets/settings_page_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02, horizontal: size.width * 0.02),
        child: Column(
          children: [
            SettingsPageCard(user: dummyUsers[0]),
            SizedBox(height: size.height * 0.02),
            SettingsPageCard(
              user: dummyUsers[0],
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

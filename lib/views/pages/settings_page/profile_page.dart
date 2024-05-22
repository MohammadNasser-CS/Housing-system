import 'package:flutter/material.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/settings_page/widgets/logout_button.dart';
import 'package:housing_project/views/pages/settings_page/widgets/profile_page_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.02, horizontal: size.width * 0.02),
      child: Column(
        children: [
          ProfilePageCard(user: dummyUsers[0]),
          SizedBox(height: size.height * 0.02),
          ProfilePageCard(
            user: dummyUsers[0],
            isChangePassword: true,
          ),
          SizedBox(height: size.height * 0.08),
          const LogoutButton(),
        ],
      ),
    );
  }
}

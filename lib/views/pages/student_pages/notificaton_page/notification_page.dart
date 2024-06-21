import 'package:flutter/material.dart';
import 'package:housing_project/models/notification_model.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/student_pages/notificaton_page/widgets/notification_card.dart';

class NotificationPage extends StatelessWidget {
  final UserModel user;
  const NotificationPage({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ListView.builder(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
              itemCount: dummyNotification.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final notification = dummyNotification[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: NotificationCard(notification: notification),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

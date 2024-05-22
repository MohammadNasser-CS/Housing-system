import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(notification.senderImg),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notification.senderName,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.bold, color: AppColor.black),
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            notification.content,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontWeight: FontWeight.bold, color: AppColor.grey),
          ),
        ],
      ),
      trailing: Text(
        notification.sinceTime,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(fontWeight: FontWeight.bold, color: AppColor.grey),
      ),
      onTap: () {
        debugPrint('move to Noti deatails');
      },
    );
  }
}

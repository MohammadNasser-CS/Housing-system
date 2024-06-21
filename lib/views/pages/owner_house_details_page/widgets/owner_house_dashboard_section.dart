import 'package:flutter/material.dart';
import 'package:housing_project/views/widgets/text_widget.dart';

class OwnerHouseDashboardSection extends StatelessWidget {
  final String roomId;
  final String studentName;
  final String phoneNumber;
  final String reservationEnd;
  final String reservationType;
  const OwnerHouseDashboardSection({
    super.key,
    required this.roomId,
    required this.studentName,
    required this.phoneNumber,
    required this.reservationEnd,
    required this.reservationType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(title: 'رقم الغرفة:', value: roomId),
            TextWidget(title: 'اسم الطالب:', value: studentName),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(title: 'رقم الهاتف:', value: phoneNumber),
            TextWidget(title: 'تاريخ انتهاء الحجز:', value: reservationEnd),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(title: 'نوع الحجز:', value: reservationType),
          ],
        ),
        const Divider(),
      ],
    );
  }
}

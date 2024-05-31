import 'package:flutter/material.dart';

import 'package:housing_project/Utils/app_color.dart';

class ContactSection extends StatelessWidget {
  final String ownerName;
  const ContactSection({super.key, required this.ownerName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsetsDirectional.all(size.width * 0.015),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.grey),
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsetsDirectional.all(size.width * 0.015),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(),
                ),
                child: const Icon(Icons.person),
              ),
              SizedBox(width: size.width * 0.02),
              Text(
                '$ownerName:',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Text(
            '0568894982',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_project/Utils/app_color.dart';

class ContactSection extends StatelessWidget {
  final String ownerName;
  const ContactSection({super.key, required this.ownerName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: size.width * 0.06,
              backgroundImage: const AssetImage(
                'assets/images/myphotocopy.jpg',
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Text(
              ownerName,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.05,
                  ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  height: size.height * 0.05,
                  width: size.width * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColor.orange8,
                  ),
                  child: Icon(
                    FontAwesomeIcons.phone,
                    size: size.width * 0.045,
                    color: AppColor.white,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.02),
              InkWell(
                onTap: () {},
                child: Container(
                  height: size.height * 0.05,
                  width: size.width * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColor.orange8,
                  ),
                  child: Icon(
                    FontAwesomeIcons.solidComment,
                    size: size.width * 0.045,
                    color: AppColor.white,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

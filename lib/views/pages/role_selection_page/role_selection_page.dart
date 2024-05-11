import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/app_routes.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'حدد نوع المستخدم',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColor.orange,
                    ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'إختر نوع المستخدم لإنشاء حسابك',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColor.grey,
                    ),
              ),
              SizedBox(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsetsDirectional.all(size.width * 0.05),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.orange),
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(
                        Icons.home_outlined,
                        color: AppColor.orange,
                        size: size.width * 0.3,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.register);
                    },
                    child: Container(
                      padding: EdgeInsetsDirectional.all(size.width * 0.05),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.orange),
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(
                        Icons.school_outlined,
                        color: AppColor.orange,
                        size: size.width * 0.3,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

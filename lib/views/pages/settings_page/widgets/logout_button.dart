import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/routes/app_routes.dart';
import 'package:housing_project/controllers/auth_cubit/auth_cubit.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              cubit.logout();
              Navigator.of(context, rootNavigator: true)
                  .pushNamed(AppRoutes.loginPage);
            },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsetsDirectional.symmetric(
                    vertical: size.width * 0.03),
                backgroundColor: AppColor.orange8,
                foregroundColor: AppColor.white),
            child: Text(
              'تسجيل الخروج',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_routes.dart';
import 'package:housing_project/controllers/add_new_house_cubit/add_new_house_cubit.dart';
import 'package:housing_project/controllers/auth_cubit/auth_cubit.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/models/house_model.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/add_new_house_page/add_new_house_page.dart';
import 'package:housing_project/views/pages/change_password_page/change_password_page.dart';
import 'package:housing_project/views/pages/forget_password_page/forget_password_page.dart';
import 'package:housing_project/views/pages/house_details_page/house_details_page.dart';
import 'package:housing_project/views/pages/custom_bottom_navbar/custom_bottom_navbar.dart';
import 'package:housing_project/views/pages/login_page/login_page.dart';
import 'package:housing_project/views/pages/password_reset_page/password_reset_page.dart';
import 'package:housing_project/views/pages/phone_number_confirm_page/phone_number_confirm_page.dart';
import 'package:housing_project/views/pages/role_selection_page/role_selection_page.dart';
import 'package:housing_project/views/pages/signup_page/signup_page.dart';
import 'package:housing_project/views/pages/profile_page/profile_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const LoginPage(),
          ),
          settings: settings,
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SignupPage(),
          ),
          settings: settings,
        );
      case AppRoutes.home:
        final UserModel user = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => CustomBottomNavbar(user: user),
          settings: settings,
        );
      case AppRoutes.details:
        final HouseModel houseItem = settings.arguments as HouseModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = HouseDetailsCubit();
              cubit.getProductDetails(houseItem.id);
              return cubit;
            },
            child: const HouseDetailsPage(),
          ),
          settings: settings,
        );
      case AppRoutes.roleSelectionPage:
        return MaterialPageRoute(
          builder: (_) => const RoleSelectionPage(),
          settings: settings,
        );
      case AppRoutes.profilePage:
        final UserModel user = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => ProfilePage(user: user),
          settings: settings,
        );
      case AppRoutes.changePasswordPage:
        final UserModel user = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => ChangePasswordPage(user: user),
          settings: settings,
        );
      case AppRoutes.forgetPasswordPage:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordPage(),
          settings: settings,
        );
      case AppRoutes.phoneNumberConfirmationPage:
        return MaterialPageRoute(
          builder: (_) => const PhoneNumberConfirmationPage(),
          settings: settings,
        );
      case AppRoutes.passwordResetPage:
        return MaterialPageRoute(
          builder: (_) => const PasswordResetPage(),
          settings: settings,
        );
      case AppRoutes.addNewHouse:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddNewHouseCubit(),
            child: const AddNewHousePage(),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
    }
  }
}

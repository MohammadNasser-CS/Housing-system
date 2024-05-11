import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_routes.dart';
import 'package:housing_project/controllers/auth_cubit/auth_cubit.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/models/house_model.dart';
import 'package:housing_project/views/pages/house_details_page/house_details_page.dart';
import 'package:housing_project/views/pages/custom_bottom_navbar.dart';
import 'package:housing_project/views/pages/login_page/login_page.dart';
import 'package:housing_project/views/pages/role_selection_page/role_selection_page.dart';
import 'package:housing_project/views/pages/signup_page/signup_page.dart';

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
        return MaterialPageRoute(
          builder: (_) => const CustomBottomNavbar(),
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
        return MaterialPageRoute(builder: (_)=>const RoleSelectionPage(),settings: settings);
      default:
        return MaterialPageRoute(
          builder: (_) => const CustomBottomNavbar(),
          settings: settings,
        );
    }
  }
}

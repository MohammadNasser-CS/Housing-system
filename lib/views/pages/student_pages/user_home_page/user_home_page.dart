import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/controllers/user_home_page_cubit/user_home_cubit.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/student_pages/user_home_page/widgets/category_slider.dart';
import 'package:housing_project/views/pages/student_pages/user_home_page/widgets/houses_section.dart';
import 'package:housing_project/views/pages/student_pages/user_home_page/widgets/search_section.dart';

class UserHomePage extends StatefulWidget {
  final UserModel user;
  const UserHomePage({super.key, required this.user});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return BlocListener<HomeCubit, HomeState>(
      bloc: cubit,
      listenWhen: (previous, current) => current is FavroiteChangedSuccess,
      listener: (context, state) {
        if (state is FavroiteChangedSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          children: [
            SearchSection(),
            SizedBox(height: 8.0),
            CategorySlider(),
            SizedBox(height: 8.0),
            Expanded(child: HousesSection()),
          ],
        ),
      ),
    );
  }
}

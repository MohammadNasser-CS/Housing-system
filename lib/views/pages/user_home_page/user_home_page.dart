import 'package:flutter/material.dart';
import 'package:housing_project/views/pages/user_home_page/widgets/category_slider.dart';
import 'package:housing_project/views/pages/user_home_page/widgets/houses_section.dart';
import 'package:housing_project/views/pages/user_home_page/widgets/search_section.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
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
    );
  }
}

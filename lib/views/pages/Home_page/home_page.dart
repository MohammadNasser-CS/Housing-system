import 'package:flutter/material.dart';
import 'package:housing_project/views/pages/Home_page/widgets/category_slider.dart';
import 'package:housing_project/views/pages/Home_page/widgets/houses_section.dart';
import 'package:housing_project/views/pages/Home_page/widgets/search_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

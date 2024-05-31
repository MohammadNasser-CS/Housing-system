import 'package:flutter/material.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/favorite_page/widgets/favorite_houses_section.dart';

class FavoritePage extends StatelessWidget {
  final UserModel user;
  const FavoritePage({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Column(
        children: [
          Expanded(child: FavoriteHousesSection()),
        ],
      ),
    );
  }
}

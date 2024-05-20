import 'package:flutter/material.dart';
import 'package:housing_project/views/pages/favorite_page/widgets/favorite_houses_section.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

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

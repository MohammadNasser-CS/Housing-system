import 'package:flutter/material.dart';
import 'package:housing_project/models/home_category_model.dart';
import 'package:housing_project/views/pages/Home_page/widgets/category_item.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            itemCount: dummyCategories.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: CategoryItem(
                  categoryItemModel: dummyCategories[index],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

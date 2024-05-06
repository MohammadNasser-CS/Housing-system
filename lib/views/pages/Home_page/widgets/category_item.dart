import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:housing_project/models/home_category_model.dart';

class CategoryItem extends StatelessWidget {
  final HomeCategoryModel categoryItemModel;
  const CategoryItem({
    super.key,
    required this.categoryItemModel,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.16,
          clipBehavior: Clip.antiAlias,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.grey.shade200,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: CachedNetworkImage(
                  imageUrl: categoryItemModel.imgUrl,
                  fit: BoxFit.cover,
                  width: size.width * 0.4,
                  height: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      categoryItemModel.category,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      'عدد العناصر: ${categoryItemModel.productsNumber}',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        // Positioned(top: 1.0, right: 1.0, child: Column()),
      ],
    );
  }
}

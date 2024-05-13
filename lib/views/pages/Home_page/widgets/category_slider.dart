import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/home_tab_view_cubit/home_cubit.dart';
import 'package:housing_project/models/home_category_model.dart';
import 'package:housing_project/models/house_model.dart';

class CategorySlider extends StatefulWidget {
  const CategorySlider({
    super.key,
  });

  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  int? selectedCategoryIndex;

  late List<HouseModel> filterdHouses;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: cubit,
      buildWhen: (previous, current) => current is HomePageCategoryChanged,
      builder: (context, state) {
        if (state is HomePageCategoryChanged) {
          return Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
                child: ListView.builder(
                  itemCount: dummyCategories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10.0),
                    child: InkWell(
                      onTap: () {
                        if (selectedCategoryIndex == null ||
                            selectedCategoryIndex != index) {
                          selectedCategoryIndex = index;
                        } else {
                          selectedCategoryIndex = null;
                          filterdHouses = dummyItems;
                          cubit.changeCategory(selectedCategoryIndex);
                        }
                        if (selectedCategoryIndex != null) {
                          // final selectedCategory =
                          //     dummyCategories[selectedCategoryIndex!];
                          // filterdHouses = dummyItems
                          //     .where((element) =>
                          //         element.category == selectedCategory.category)
                          //     .toList();
                          cubit.changeCategory(selectedCategoryIndex);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedCategoryIndex == index
                              ? Colors.orange
                              : Colors.white,
                          shape: BoxShape.rectangle,
                          border: Border.all(color: AppColor.orange),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dummyCategories[index].category,
                                style: TextStyle(
                                    color: selectedCategoryIndex == index
                                        ? Colors.white
                                        : Colors.orange,
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Positioned(top: 1.0, right: 1.0, child: Column()),
            ],
          );
        } else {
          return Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
                child: ListView.builder(
                  itemCount: dummyCategories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10.0),
                    child: InkWell(
                      onTap: () {
                        if (selectedCategoryIndex == null ||
                            selectedCategoryIndex != index) {
                          selectedCategoryIndex = index;
                        } else {
                          selectedCategoryIndex = null;
                          filterdHouses = dummyItems;
                          cubit.changeCategory(selectedCategoryIndex);
                        }
                        if (selectedCategoryIndex != null) {
                          // final selectedCategory =
                          //     dummyCategories[selectedCategoryIndex!];
                          // filterdHouses = dummyItems
                          //     .where((element) =>
                          //         element.category == selectedCategory.category)
                          //     .toList();
                          cubit.changeCategory(selectedCategoryIndex);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedCategoryIndex == index
                              ? Colors.orange
                              : Colors.white,
                          shape: BoxShape.rectangle,
                          border: Border.all(color: AppColor.orange),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dummyCategories[index].category,
                                style: TextStyle(
                                    color: selectedCategoryIndex == index
                                        ? Colors.white
                                        : Colors.orange,
                                    fontSize: size.width * 0.025),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Positioned(top: 1.0, right: 1.0, child: Column()),
            ],
          );
        }
      },
    );
  }
}

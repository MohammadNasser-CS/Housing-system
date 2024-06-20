import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/routes/app_routes.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/controllers/owner_home_page_cubit/owner_home_page_cubit.dart';
import 'package:housing_project/views/pages/owner_home_page/widgets/home_tap_view_widgets/owner_house_item.dart';
import 'package:housing_project/views/pages/owner_home_page/widgets/owner_home_search_section.dart';
import 'package:housing_project/views/widgets/no_items_wiget.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OwnerHomePageCubit>(context);
    return BlocBuilder<OwnerHomePageCubit, OwnerHomePageState>(
      bloc: cubit,
      buildWhen: (previous, current) {
        return current is! HouseDetailsLoaded;
      },
      builder: (context, state) {
        if (state is OwnerHomePageLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is OwnerHomePageError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is OwnerHomePageLoaded && state.houses.isNotEmpty) {
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  return await cubit.getHomeData();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const OwnerHomePageSearchSectionSearchSection(),
                      const SizedBox(height: 24.0),
                      ListView.builder(
                        itemCount: state.houses.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () async {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(
                                  AppRoutes.details,
                                  arguments: state.houses[index],
                                )
                                .then((value) => cubit.getHomeData());
                          },
                          child: OwnerHouseItem(
                            cubit: cubit,
                            houseItemModel: state.houses[index],
                          ),
                        ),
                      ),
                      if (state.houses.length < 2)
                        Container(
                          height: MediaQuery.of(context).size.height,
                          color: Colors.transparent,
                        ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 5.0,
                right: 16.0,
                child: FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(AppRoutes.addNewHouse)
                        .then((value) {
                      return cubit.getHomeData();
                    });
                  },
                  foregroundColor: AppColor.white,
                  backgroundColor: AppColor.orange8,
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          );
        } else {
          return Stack(
            children: [
              const NoItemsWidget(
                  title: 'لم يتم إضافة أي عقار',
                  icon: FontAwesomeIcons.building),
              Positioned(
                bottom: 5.0,
                right: 16.0,
                child: FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(AppRoutes.addNewHouse)
                        .then((value) {
                      return cubit.getHomeData();
                    });
                  },
                  foregroundColor: AppColor.white,
                  backgroundColor: AppColor.orange8,
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

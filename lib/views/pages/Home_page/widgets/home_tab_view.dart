import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/app_routes.dart';
import 'package:housing_project/controllers/home_tab_view_cubit/home_cubit.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/views/pages/Home_page/widgets/house_item.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubitBase = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: cubitBase,
      buildWhen: (previous, current) {
        return current is! HouseDetailsLoaded;
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is HomeError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is HomeLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              return await cubitBase.getHomeData();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'السكنات',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: cubitBase,
                    buildWhen: (previous, current) =>
                        current is HomePageFavroiteChangeLoaded ||
                        current is HomeLoaded,
                    builder: (context, state) {
                      if (state is HomePageFavroiteChangeLoaded) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 22,
                            childAspectRatio: 0.75,
                          ),
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
                                  .then((value) => cubitBase.getHomeData());
                            },
                            child: HouseItem(
                              cubit: cubitBase,
                              productItemModel: state.houses[index],
                            ),
                          ),
                        );
                      } else if (state is HomeLoaded) {
                        return ListView.builder(
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
                                  .then((value) => cubitBase.getHomeData());
                            },
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              margin:
                                  const EdgeInsetsDirectional.only(bottom: 8.0),
                              decoration: BoxDecoration(
                                color: AppColor.grey2,
                                borderRadius: BorderRadius.circular(24.0),
                                border: Border.all(color: AppColor.grey4),
                              ),
                              child: HouseItem(
                                cubit: cubitBase,
                                productItemModel: state.houses[index],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/routes/app_routes.dart';
import 'package:housing_project/controllers/user_home_page_cubit/user_home_cubit.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/views/pages/shared_pages/widgets/no_items_wiget.dart';
import 'package:housing_project/views/pages/student_pages/user_home_page/widgets/house_item.dart';

class HousesSection extends StatelessWidget {
  const HousesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: cubit,
      buildWhen: (previous, current) => current is! HouseDetailsLoaded,
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is HomeError) {
          return NoItemsWidget(title: state.message, icon: Icons.block);
        } else if (state is HomeLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              await cubit.getHomeData();
              await cubit.changeCategory(null);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: cubit,
                    buildWhen: (previous, current) => current is HomeLoaded,
                    builder: (context, state) {
                      if (state is HomeLoaded) {
                        return Column(
                          children: [
                            ListView.builder(
                              itemCount: state.houses.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => InkWell(
                                onTap: () async {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(
                                        AppRoutes.details,
                                        arguments: state.houses[index].houseId,
                                      )
                                      .then((value) => cubit.getHomeData());
                                },
                                child: HouseItem(
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

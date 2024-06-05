import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_routes.dart';
import 'package:housing_project/controllers/user_home_page_cubit/user_home_cubit.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/views/pages/user_home_page/widgets/house_item.dart';

class HousesSection extends StatelessWidget {
  const HousesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubitBase = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: cubitBase,
      buildWhen: (previous, current) => current is! HouseDetailsLoaded,
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
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: cubitBase,
                    buildWhen: (previous, current) => current is HomeLoaded,
                    builder: (context, state) {
                      if (state is HomeLoaded) {
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
                            child: HouseItem(
                              cubit: cubitBase,
                              houseItemModel: state.houses[index],
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

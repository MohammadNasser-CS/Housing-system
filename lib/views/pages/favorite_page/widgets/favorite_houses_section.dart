import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/routes/app_routes.dart';
import 'package:housing_project/controllers/favorite_page_cubit/favorite_cubit.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/views/pages/user_home_page/widgets/house_item.dart';

class FavoriteHousesSection extends StatelessWidget {
  const FavoriteHousesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubitBase = BlocProvider.of<FavoriteCubit>(context);
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      bloc: cubitBase,
      buildWhen: (previous, current) => current is! HouseDetailsLoaded,
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is FavoriteError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is FavoriteLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<FavoriteCubit, FavoriteState>(
                  bloc: cubitBase,
                  buildWhen: (previous, current) => current is FavoriteLoaded,
                  builder: (context, state) {
                    if (state is FavroiteChangeLoaded) {
                      return ListView.builder(
                        itemCount: state.houses.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () async {
                            debugPrint(state.houses[index].toString());
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(
                                  AppRoutes.details,
                                  arguments: state.houses[index],
                                )
                                .then((value) => cubitBase.getFavoriteHouses());
                          },
                          child: HouseItem(
                            cubit: cubitBase,
                            houseItemModel: state.houses[index],
                          ),
                        ),
                      );
                    } else if (state is FavoriteLoaded) {
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
                                .then((value) => cubitBase.getFavoriteHouses());
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
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

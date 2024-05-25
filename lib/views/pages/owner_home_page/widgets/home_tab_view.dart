import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/app_routes.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/controllers/owner_home_page_cubit/owner_home_page_cubit.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/owner_home_page/widgets/owner_house_item.dart';
import 'package:housing_project/views/pages/owner_home_page/widgets/owner_no_houese_wiget.dart';

class HomeTabView extends StatelessWidget {
  final UserModel user;
  const HomeTabView({super.key, required this.user});

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
        } else if (state is OwnerHomePageLoaded) {
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  return await cubit.getHomeData(user);
                },
                child: state.houses.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 24.0),
                            BlocBuilder<OwnerHomePageCubit, OwnerHomePageState>(
                              bloc: cubit,
                              buildWhen: (previous, current) =>
                                  current is OwnerHomePageLoaded,
                              builder: (context, state) {
                                if (state is OwnerHomePageLoaded) {
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () async {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushNamed(
                                              AppRoutes.details,
                                              arguments: state.houses[index],
                                            )
                                            .then((value) =>
                                                cubit.getHomeData(user));
                                      },
                                      child: OwnerHouseItem(
                                        cubit: cubit,
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
                      )
                    : const NoHousesWidget(title: 'لم يتم إضافة أي عقار'),
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
                      return cubit.getHomeData(user);
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
          return const SizedBox();
        }
      },
    );
  }
}

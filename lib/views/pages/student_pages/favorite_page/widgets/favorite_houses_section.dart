import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_project/Utils/routes/app_routes.dart';
import 'package:housing_project/controllers/favorite_page_cubit/favorite_cubit.dart';
import 'package:housing_project/controllers/house_details/house_details_cubit.dart';
import 'package:housing_project/views/pages/student_pages/user_home_page/widgets/house_item.dart';
import 'package:housing_project/views/pages/shared_pages/widgets/no_items_wiget.dart';

class FavoriteHousesSection extends StatelessWidget {
  const FavoriteHousesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FavoriteCubit>(context);
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      bloc: cubit,
      listenWhen: (previous, current) => current is FavroiteChangedSuccess,
      listener: (context, state) {
        if (state is FavroiteChangedSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      buildWhen: (previous, current) => current is! HouseDetailsLoaded,
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is FavoriteError) {
          return Center(
            child: NoItemsWidget(
                title: state.message, icon: FontAwesomeIcons.heartCircleXmark),
          );
        } else if (state is FavoriteLoaded) {
          return SingleChildScrollView(
            child: Column(
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
                            arguments: state.houses[index],
                          )
                          .then((value) => cubit.getFavoriteHouses());
                    },
                    child: HouseItem(
                      cubit: cubit,
                      houseItemModel: state.houses[index],
                    ),
                  ),
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

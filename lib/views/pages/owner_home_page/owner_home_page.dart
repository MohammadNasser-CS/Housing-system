import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/owner_home_page_cubit/owner_home_page_cubit.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/owner_home_page/widgets/category_tab_view.dart';
import 'package:housing_project/views/pages/owner_home_page/widgets/home_tab_view.dart';
import 'package:housing_project/views/pages/owner_home_page/widgets/owner_home_search_section.dart';

class OwnerHomePage extends StatefulWidget {
  final UserModel user;
  const OwnerHomePage({super.key, required this.user});
  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          children: [
            const OwnerHomePageSearchSectionSearchSection(),
            SizedBox(height: size.height * 0.025),
            DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: TabBar(
                indicatorWeight: 2.5,
                indicatorColor: AppColor.orange8,
                controller: _tabController,
                unselectedLabelColor: AppColor.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                unselectedLabelStyle:
                    Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                labelColor: AppColor.orange8,
                tabs: const [
                  Tab(text: 'المتاحة'),
                  Tab(text: 'المحجوزة'),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.025),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocProvider(
                    create: (context) {
                      final homeCubit = OwnerHomePageCubit();
                      homeCubit.getHomeData(widget.user);
                      return homeCubit;
                    },
                    child: HomeTabView(user: widget.user),
                  ),
                  BlocProvider(
                    create: (context) {
                      final categoryCubit = OwnerHomePageCubit();
                      categoryCubit.getHomeData(widget.user);
                      return categoryCubit;
                    },
                    child: CategoryTabView(user: widget.user),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

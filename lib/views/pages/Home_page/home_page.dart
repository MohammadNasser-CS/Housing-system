import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/category_tab_view/category_cubit.dart';
import 'package:housing_project/controllers/home_tab_view_cubit/home_cubit.dart';
import 'package:housing_project/views/pages/Home_page/widgets/category_tab_view.dart';
import 'package:housing_project/views/pages/Home_page/widgets/home_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Column(
        children: [
          const SizedBox(height: 24.0),
          TabBar(
            controller: _tabController,
            unselectedLabelColor: AppColor.grey,
            tabs: const [
              Tab(text: 'الصفحة الرئيسية'),
              Tab(text: 'تصنيفات'),
            ],
          ),
          const SizedBox(height: 24.0),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                BlocProvider(
                  create: (context) {
                    final homeCubit = HomeCubit();
                    homeCubit.getHomeData();
                    return homeCubit;
                  },
                  child: const HomeTabView(),
                ),
                BlocProvider(
                  create: (context) {
                    final categoryCubit = CategoryCubit();
                    categoryCubit.getCategoryData();
                    return categoryCubit;
                  },
                  child: const CategoryTabView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

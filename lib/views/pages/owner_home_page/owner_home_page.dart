import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/owner_home_page_cubit/owner_home_page_cubit.dart';
import 'package:housing_project/views/pages/owner_home_page/widgets/request_tab_view.dart';
import 'package:housing_project/views/pages/owner_home_page/widgets/home_tab_view.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({
    super.key,
  });
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
    final cubit = BlocProvider.of<OwnerHomePageCubit>(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        child: BlocBuilder<OwnerHomePageCubit, OwnerHomePageState>(
          bloc: cubit,
          buildWhen: (previous, current) => current is TapViewChanged,
          builder: (context, state) {
            return Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: AppColor.grey, width: 2.0),
                  ),
                  child: TabBar(
                    onTap: (value) {
                      cubit.chaneTapView();
                    },
                    indicatorWeight: 2.5,
                    indicatorColor: AppColor.orange8,
                    controller: _tabController,
                    unselectedLabelColor: AppColor.grey,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                    unselectedLabelStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                    labelColor: AppColor.orange8,
                    tabs: const [
                      Tab(text: 'عقاراتي'),
                      Tab(text: 'الطلبات'),
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
                          homeCubit.getHomeData();
                          return homeCubit;
                        },
                        child: const HomeTabView(),
                      ),
                      BlocProvider(
                        create: (context) {
                          final requestCubit = OwnerHomePageCubit();
                          requestCubit.getRequestsData();
                          return requestCubit;
                        },
                        child: const RequestsTabView(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

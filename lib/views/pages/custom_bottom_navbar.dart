import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/favorite_page_cubit/favorite_cubit.dart';
import 'package:housing_project/controllers/home_tab_view_cubit/home_cubit.dart';
import 'package:housing_project/controllers/my_room_page_cubit/my_room_cubit.dart';
import 'package:housing_project/views/pages/Home_page/home_page.dart';
import 'package:housing_project/views/pages/my_room_page/my_room_page.dart';
import 'package:housing_project/views/pages/favorite_page/favorite_page.dart';
import 'package:housing_project/views/pages/profile_page/profile_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  late final PersistentTabController _controller;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    _controller.addListener(() {
      setState(() {
        currentIndex = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<PersistentTabConfig> _buildScreens() {
    return [
      PersistentTabConfig(
        screen: BlocProvider(
          create: (context) {
            final cubit = HomeCubit();
            cubit.getHomeData();
            return cubit;
          },
          child: const HomePage(),
        ),
        item: ItemConfig(
          icon: const Icon(Icons.home_outlined),
          title: "الرئيسية",
          activeForegroundColor: AppColor.black,
          inactiveForegroundColor: Colors.white,
        ),
      ),
      PersistentTabConfig(
        screen: BlocProvider(
          create: (context) {
            final cubit = MyRoomCubit();
            cubit.getMyRoom('1', '1');
            return cubit;
          },
          child: const MyRoomPage(),
        ),
        item: ItemConfig(
          icon: const Icon(Icons.bedroom_child_outlined),
          title: "غرفتي",
          activeForegroundColor: AppColor.black,
          inactiveForegroundColor: Colors.white,
        ),
      ),
      PersistentTabConfig(
        screen: BlocProvider(
          create: (context) {
            final cubit = FavoriteCubit();
            cubit.getFavoriteHouses();
            return cubit;
          },
          child: const FavoritePage(),
        ),
        item: ItemConfig(
          icon: const Icon(Icons.favorite_border),
          title: "المفضلة",
          activeForegroundColor: AppColor.black,
          inactiveForegroundColor: Colors.white,
        ),
      ),
      PersistentTabConfig(
        screen: const ProfilePage(),
        item: ItemConfig(
          icon: const Icon(Icons.settings),
          title: "الإعدادات",
          activeForegroundColor: AppColor.black,
          inactiveForegroundColor: Colors.white,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.orange,
          centerTitle: true,
          leading: const SizedBox.shrink(),
          title: _controller.index == 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'الصفحة الرئيسية',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.white,
                          ),
                    ),
                  ],
                )
              : _controller.index == 1
                  ? Center(
                      child: Text(
                      'غرفتي',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.white,
                          ),
                    ))
                  : _controller.index == 2
                      ? Center(
                          child: Text(
                            'الغرف المفلضة',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.white,
                                ),
                          ),
                        )
                      : null,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none_outlined,
                color: AppColor.white,
                size: size.width * 0.06,
              ),
            ),
          ],
        ),
        body: PersistentTabView(
          controller: _controller,
          navBarBuilder: (navBarConfig) => Style1BottomNavBar(
            navBarConfig: navBarConfig,
            navBarDecoration: const NavBarDecoration(color: AppColor.orange),
          ),
          tabs: _buildScreens(),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            curve: Curves.ease,
            duration: Duration(milliseconds: 400),
          ),
          stateManagement: false,
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/controllers/favorite_page_cubit/favorite_cubit.dart';
import 'package:housing_project/controllers/user_home_page_cubit/user_home_cubit.dart';
import 'package:housing_project/controllers/my_room_page_cubit/my_room_cubit.dart';
import 'package:housing_project/models/user_model.dart';
import 'package:housing_project/views/pages/owner_home_page/owner_home_page.dart';
import 'package:housing_project/views/pages/user_home_page/user_home_page.dart';
import 'package:housing_project/views/pages/custom_bottom_navbar/widgets/app_bar_title_for_owner.dart';
import 'package:housing_project/views/pages/custom_bottom_navbar/widgets/app_bar_title_for_user.dart';
import 'package:housing_project/views/pages/my_room_page/my_room_page.dart';
import 'package:housing_project/views/pages/favorite_page/favorite_page.dart';
import 'package:housing_project/views/pages/notificaton_page/notification_page.dart';
import 'package:housing_project/views/pages/settings_page/settings_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavbar extends StatefulWidget {
  final UserModel user;
  const CustomBottomNavbar({super.key, required this.user});

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

  List<PersistentTabConfig> _buildUserScreens() {
    return [
      PersistentTabConfig(
        screen: BlocProvider(
          create: (context) {
            final cubit = HomeCubit();
            cubit.getHomeData();
            return cubit;
          },
          child: const UserHomePage(),
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
        screen: const NotificationPage(),
        item: ItemConfig(
          icon: const Icon(Icons.notifications_none_outlined),
          title: "الإشعارات",
          activeForegroundColor: AppColor.black,
          inactiveForegroundColor: Colors.white,
        ),
      ),
      PersistentTabConfig(
        screen: const SettingsPage(),
        item: ItemConfig(
          icon: const Icon(Icons.person_2_outlined),
          title: "الإعدادت",
          activeForegroundColor: AppColor.black,
          inactiveForegroundColor: Colors.white,
        ),
      ),
    ];
  }

  List<PersistentTabConfig> _buildOwnerScreens() {
    return [
      PersistentTabConfig(
        screen: BlocProvider(
          create: (context) {
            final cubit = HomeCubit();
            cubit.getHomeData();
            return cubit;
          },
          child: const OwnerHomePage(),
        ),
        item: ItemConfig(
          icon: const Icon(FontAwesomeIcons.building),
          title: "عقاراتي",
          activeForegroundColor: AppColor.black,
          inactiveForegroundColor: Colors.white,
        ),
      ),
      PersistentTabConfig(
        screen: const NotificationPage(),
        item: ItemConfig(
          icon: const Icon(Icons.notifications_none_outlined),
          title: "الإشعارات",
          activeForegroundColor: AppColor.black,
          inactiveForegroundColor: Colors.white,
        ),
      ),
      PersistentTabConfig(
        screen: const SettingsPage(),
        item: ItemConfig(
          icon: const Icon(Icons.person_2_outlined),
          title: "الإعدادت",
          activeForegroundColor: AppColor.black,
          inactiveForegroundColor: Colors.white,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          leading: const SizedBox.shrink(),
          title: widget.user.role == 'houseOwner'
              ? AppBarTitleForOwner(index: _controller.index)
              : AppBarTitleForUser(index: _controller.index),
        ),
        body: PersistentTabView(
          controller: _controller,
          navBarBuilder: (navBarConfig) => Style1BottomNavBar(
            navBarConfig: navBarConfig,
            navBarDecoration:
                NavBarDecoration(color: Theme.of(context).primaryColor),
          ),
          tabs: widget.user.role == 'houseOwner'
              ? _buildOwnerScreens()
              : _buildUserScreens(),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            curve: Curves.ease,
            duration: Duration(milliseconds: 400),
          ),
          stateManagement: false,
        ));
  }
}

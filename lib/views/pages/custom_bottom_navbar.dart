import 'package:flutter/material.dart';
import 'package:housing_project/Utils/app_color.dart';
import 'package:housing_project/Utils/app_routes.dart';
import 'package:housing_project/views/pages/Home_page/home_page.dart';
import 'package:housing_project/views/pages/cart_page/cart_page.dart';
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
        screen: const HomePage(),
        item: ItemConfig(
          icon: const Icon(Icons.home),
          title: "الرئيسية",
          activeForegroundColor: Theme.of(context).primaryColor,
          inactiveForegroundColor: Colors.grey,
        ),
      ),
      PersistentTabConfig(
        screen: const CartPage(),
        item: ItemConfig(
          icon: const Icon(Icons.bedroom_child_outlined),
          title: "غرفتي",
          activeForegroundColor: Theme.of(context).primaryColor,
          inactiveForegroundColor: Colors.grey,
        ),
      ),
      PersistentTabConfig(
        screen: const FavoritePage(),
        item: ItemConfig(
          icon: const Icon(Icons.favorite_border),
          title: "المفضلة",
          activeForegroundColor: Theme.of(context).primaryColor,
          inactiveForegroundColor: Colors.grey,
        ),
      ),
      PersistentTabConfig(
        screen: const ProfilePage(),
        item: ItemConfig(
          icon: const Icon(Icons.settings),
          title: "الإعدادات",
          activeForegroundColor: Theme.of(context).primaryColor,
          inactiveForegroundColor: Colors.grey,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsetsDirectional.only(start: 8.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/myphotocopy.jpg'),
            ),
          ),
          title: _controller.index == 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مرحبا، محمد!',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                    ),
                    Text(
                      'هيا لنختار غرفة مناسبة لك...',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: AppColor.darkGrey, fontSize: 16),
                    )
                  ],
                )
              : _controller.index == 1
                  ? const Center(child: Text('غرفتي'))
                  : _controller.index == 2
                      ? const Center(child: Text('الغرف المفلضة'))
                      : null,
          actions: [
            if (_controller.index == 0) ...[
              IconButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pushNamed(
                    AppRoutes.search,
                  );
                },
                icon: const Icon(Icons.filter_alt_outlined),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              ),
            ],
            if (_controller.index == 1)
              if (_controller.index == 2)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                ),
          ],
        ),
        body: PersistentTabView(
          controller: _controller,
          navBarBuilder: (navBarConfig) => Style1BottomNavBar(
            navBarConfig: navBarConfig,
          ),
          tabs: _buildScreens(),
          backgroundColor: Colors.white, // Default is Colors.white.
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            curve: Curves.ease,
            duration: Duration(milliseconds: 400),
          ),
          stateManagement: false,
        ));
  }
}

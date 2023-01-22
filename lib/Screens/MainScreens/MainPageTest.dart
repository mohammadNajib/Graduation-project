import 'package:co_chef_mobile/Screens/AddressScreen.dart';
import 'package:co_chef_mobile/Screens/Drawer/Drawer.dart';
import 'package:co_chef_mobile/Screens/MainScreens/MainScreen.dart';
import 'package:co_chef_mobile/Screens/MainScreens/Screen1.dart';
import 'package:co_chef_mobile/Screens/MainScreens/Screen2.dart';
import 'package:co_chef_mobile/Screens/MainScreens/Screen3.dart';
import 'package:co_chef_mobile/Screens/MainScreens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

import '../AddAdressScreen.dart';
import '../AddRecipeScreen.dart';
import '../RecipeScreen.dart';
import '../UsersList.dart';
import '../CartScreen.dart';
import '../searchScreen.dart';

class MainSkeleton extends StatefulWidget {
  MainSkeleton({Key? key}) : super(key: key);

  static String route = '/mainPageTest';

  @override
  _MainSkeletonState createState() => _MainSkeletonState();
}

class _MainSkeletonState extends State<MainSkeleton> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Co-Chef', style: TextStyle(fontSize: 20.0, fontFamily: 'Pacifico')),
        backgroundColor: AppColors.color2,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                child: Icon(Icons.search, size: 35.0)),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: AppColors.color2,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        // onWillPop: (context) async {
        //   await showDialog(
        //     context: context,
        //     useSafeArea: true,
        //     builder: (context) => Container(
        //       height: 50.0,
        //       width: 50.0,
        //       color: Colors.white,
        //       child: ElevatedButton(
        //         child: Text("Close"),
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //     ),
        //   );
        //   return false;
        // },

        decoration: NavBarDecoration(
            colorBehindNavBar: Colors.indigo,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
        popAllScreensOnTapOfSelectedTab: false,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 300),
        ),
        navBarStyle: NavBarStyle.style12,
      ),
    );
  }
}

List<Widget> _buildScreens() {
  return [
    MainScreen(),
    Screen2(),
    Screen3(),
    ProfileScreen(),
  ];
}

final RouteAndNavigatorSettings routeAndNavigatorSettings = RouteAndNavigatorSettings(
  initialRoute: '/page1',
  routes: {
    '/page1': (context) => Screen1(),
    '/page2': (context) => Screen2(),
    '/page3': (context) => Screen3(),
    '/Profile': (context) => ProfileScreen(),
    '/RecipeScreen': (context) => RecipeScreen(
          recipe: null,
        ),
    '/IngredientsScreen': (context) => CartScreen(),
    '/AddRecipeScreen': (context) => AddRecipeScreen(),
    UsersList.route: (context) => UsersList(),
    AddressScreen.route: (context) => AddressScreen(),
    AddAddressScreen.route: (context) => AddAddressScreen(),
  },
);

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: AppColors.color1,
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: routeAndNavigatorSettings),
    PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        title: ("Store"),
        activeColorPrimary: AppColors.color1,
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: routeAndNavigatorSettings),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.fastfood_rounded),
      title: ("Cart"),
      iconSize: 26.0,
      activeColorPrimary: AppColors.color1,
      inactiveColorPrimary: Colors.white,
      routeAndNavigatorSettings: routeAndNavigatorSettings,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.person),
      title: ("Profile"),
      activeColorPrimary: AppColors.color1,
      inactiveColorPrimary: Colors.white,
      routeAndNavigatorSettings: routeAndNavigatorSettings,
    ),
  ];
}

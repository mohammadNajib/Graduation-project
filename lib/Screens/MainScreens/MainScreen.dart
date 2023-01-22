import 'package:co_chef_mobile/Screens/MealsScreen.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

import 'Screen1.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: new Scaffold(
        backgroundColor: AppColors.color2,
        appBar: TabBar(
          labelColor: AppColors.color4,
          indicatorColor: AppColors.color2,
          controller: _tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.food_bank)),
            Tab(
              icon: Icon(Icons.restaurant),
            )
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Screen1(),
            MealsScreen(),
          ],
        ),
      ),
    );
  }
}

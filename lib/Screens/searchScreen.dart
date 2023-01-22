import 'package:co_chef_mobile/Screens/MealFilterScreen.dart';
import 'package:co_chef_mobile/Screens/RecipeFilterScreen.dart';
import 'package:co_chef_mobile/Screens/UserSearchScreen.dart';
import 'package:flutter/material.dart';

import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_search_bar/flutter_search_bar.dart';

enum SearchFilter { Person, Recipe }

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 3);

    super.initState();
  }

  late SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('بحث و فلترة', textDirection: TextDirection.rtl),
      backgroundColor: AppColors.color2,
      // actions: [searchBar.getSearchAction(context)],
      bottom: new TabBar(
        controller: _tabController,
        indicatorColor: AppColors.color2,
        tabs: <Widget>[
          Tab(icon: Icon(Icons.person)),
          Tab(icon: Icon(Icons.fastfood_rounded)),
          Tab(icon: Icon(Icons.restaurant)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: new Scaffold(
        appBar: searchBar.build(context),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[UserSearchScreen(), RecipeFilterScreen(), MealFilterScreen()],
        ),
      ),
    );
  }
}

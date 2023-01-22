import 'package:co_chef_mobile/Screens/AddMealScreen.dart';
import 'package:co_chef_mobile/Screens/ChefOrdersScreen.dart';
import 'package:co_chef_mobile/Screens/LoginPage.dart';
import 'package:co_chef_mobile/Screens/MainScreens/MainPageTest.dart';
import 'package:co_chef_mobile/Screens/PasswordPage.dart';
import 'package:co_chef_mobile/Screens/SignupPage.dart';
import 'package:co_chef_mobile/Screens/WelcomePage.dart';
import 'package:co_chef_mobile/Screens/myRecipes.dart';
import 'package:co_chef_mobile/Screens/userProfile.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  WelcomePage.route: (BuildContext context) => WelcomePage(),
  LoginPage.route: (BuildContext context) => LoginPage(),
  PasswordPage.route: (BuildContext context) => PasswordPage(),
  SignUpPage.route: (BuildContext context) => SignUpPage(),
  MainSkeleton.route: (BuildContext context) => MainSkeleton(),
  UserProfile.route: (BuildContext context) => UserProfile(),
  MyRecipes.route: (BuildContext context) => MyRecipes(),
  ChefOrderScreen.route: (BuildContext context) => ChefOrderScreen(),
  AddMealScreen.route: (BuildContext context) => AddMealScreen(),
};

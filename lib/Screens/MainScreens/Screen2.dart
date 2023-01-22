import 'package:co_chef_mobile/Screens/CartScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  Screen2({Key? key}) : super(key: key);

  static String route = "/page2";

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  bool favorite = false;
  GlobalKey itemKey = GlobalKey();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CartScreen();
  }
}

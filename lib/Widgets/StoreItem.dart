import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Widgets/ListItem.dart';
import 'package:flutter/material.dart';

class StoreItem extends StatelessWidget {
  final String? route;
  final String text;

  const StoreItem({
    Key? key,
    this.route,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItem(
      route: route!,
      width: MediaQuery.of(context).size.width * 0.44,
      height: 95,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: appTextStyle.copyWith(fontSize: 20.0),
      ),
    );
  }
}

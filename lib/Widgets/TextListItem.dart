import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:flutter/material.dart';

class TextListItem extends StatelessWidget {
  final String text;

  const TextListItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: TextAlign.center, style: appTextStyle);
  }
}

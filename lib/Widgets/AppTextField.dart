import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Screens/WelcomePage.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final double width;
  final double? height;
  final TextEditingController controller;
  final String hintText;
  final TextInputType? textInputType;
  final Function? onTap;
  final Color? color;

  const AppTextField({
    Key? key,
    required this.width,
    required this.controller,
    required this.hintText,
    this.textInputType,
    this.height,
    this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: color ?? color2, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(20.0))),
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        style: textStyle,
        onTap: () => onTap!(),
        cursorColor: Colors.white,
        autofocus: false,
        textInputAction: TextInputAction.done,
        textAlign: TextAlign.center,
        keyboardType: textInputType,
        maxLines: 10,
        minLines: 1,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white, fontSize: 15.0),
            errorStyle: TextStyle(
              color: Colors.red,
            )),
      ),
    );
  }
}

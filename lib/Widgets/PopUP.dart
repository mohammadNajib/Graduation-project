import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  final String? text;
  final Function? onTap;
  final double height;
  final Widget? child;
  final double? width;
  final Color? color;

  const PopUp({
    Key? key,
    required this.height,
    this.onTap,
    this.child,
    this.width,
    this.color,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Center(
          child: (text == null) ? child : Text(text!, style: TextStyle(color: Colors.white, fontSize: 15.0)),
        ),
        margin: EdgeInsets.all(8.0),
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color ?? color2,
            border: Border.all(color: color2, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
      ),
      onTap: () => onTap!(),
    );
  }
}

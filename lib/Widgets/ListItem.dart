import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String route;
  final String? imagePath;
  final Widget? child;
  final double width;
  final double height;

  const ListItem({Key? key, required this.route, this.imagePath, this.child, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => route != 'route' ? Navigator.pushNamed(context, route) : print('go ya basha'),
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5, offset: Offset(3.0, 3.0))],
          color: Colors.white,
          border: Border.all(color: color2, width: 1),
          image: DecorationImage(image: AssetImage('images/white.jpg'), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        child: Center(child: child),
      ),
    );
  }
}

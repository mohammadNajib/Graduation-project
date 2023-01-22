import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

class DrawerWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function? function;

  const DrawerWidget({Key? key, required this.icon, required this.text, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function!(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        margin: EdgeInsets.only(left: 20.0),
        width: double.infinity,
        child: Row(
          children: [
            Icon(icon, size: 32),
            SizedBox(width: 30.0),
            Text(text, style: TextStyle(color: AppColors.color2, fontWeight: FontWeight.w600, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final String? data;
  final String text;
  final Color? textColor;
  final String? route;
  final Function? onTap;

  const ProfileIcon({
    Key? key,
    this.data,
    required this.text,
    this.textColor,
    this.route,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            Text(text, style: TextStyle(color: textColor == null ? Colors.white : textColor)),
            SizedBox(height: 3),
            Text(data != null ? data! : '', style: TextStyle(color: textColor == null ? Colors.white : textColor))
          ],
        ),
        onTap: () => onTap!(),
      ),
    );
  }
}

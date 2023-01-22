import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final String data;
  final Function onTap;
  final double? width;
  const ProfileButton({
    Key? key,
    required this.icon,
    required this.data,
    required this.onTap,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: MediaQuery.of(context).size.height / 10,
        width: width ?? MediaQuery.of(context).size.width / 2.25,
        decoration: BoxDecoration(
            color: AppColors.color3,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 6, blurRadius: 4)]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                data,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

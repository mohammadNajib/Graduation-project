import 'dart:ui';
import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:flutter/material.dart';

class BlurredImage extends StatelessWidget {
  final String text;

  const BlurredImage({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: new BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 02.0, sigmaY: 002.0),
        child: Center(child: Text(text, textAlign: TextAlign.center, style: appTextStyle)),
      ),
    );
  }
}

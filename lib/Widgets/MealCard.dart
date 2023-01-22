import 'dart:ui';

import 'package:co_chef_mobile/Models/MealOrder.dart';
import 'package:co_chef_mobile/Screens/MealDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

class MealCard extends StatelessWidget {
  const MealCard({Key? key, required this.meal}) : super(key: key);

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MealDetailsScreen(meal: meal)));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 150,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black, blurRadius: 5, offset: Offset(3.0, 3.0)),
              ],
              color: Colors.white,
              border: Border.all(color: AppColors.color2, width: 1),
              image: DecorationImage(image: AssetImage('images/white.jpg'), fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: new BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 02.0, sigmaY: 002.0),
                  child: Center(
                    child: Text(
                      meal.name ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          shadows: [BoxShadow(color: Colors.black, blurRadius: 8, spreadRadius: 10)]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

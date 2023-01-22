// To parse this JSON data, do
//
//     final mealResponse = mealResponseFromJson(jsonString);

import 'dart:convert';

import 'MealOrder.dart';

MealResponse mealResponseFromJson(String str) => MealResponse.fromJson(json.decode(str));

String mealResponseToJson(MealResponse data) => json.encode(data.toJson());

class MealResponse {
  MealResponse({
    this.meals,
    this.message,
  });

  List<Meal>? meals;
  String? message;

  factory MealResponse.fromJson(Map<String, dynamic> json) => MealResponse(
        meals: List<Meal>.from(json["data"].map((x) => Meal.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(meals!.map((x) => x.toJson())),
        "message": message,
      };
}

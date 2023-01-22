// To parse this JSON data, do
//
//     final ingredientDetails = ingredientDetailsFromJson(jsonString);

import 'dart:convert';

import 'Ingredient.dart';

IngredientDetails ingredientDetailsFromJson(String str) => IngredientDetails.fromJson(json.decode(str));

String ingredientDetailsToJson(IngredientDetails data) => json.encode(data.toJson());

class IngredientDetails {
  IngredientDetails({this.ingredient, this.recommended, this.message});

  IngredientShop? ingredient;
  Recomended? recommended;
  String? message;

  factory IngredientDetails.fromJson(Map<String, dynamic> json) => IngredientDetails(
        ingredient: IngredientShop.fromJson(json["data"]),
        recommended: Recomended.fromJson(json["recomended"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": ingredient!.toJson(),
        "recomended": recommended!.toJson(),
        "message": message,
      };
}

class Recomended {
  Recomended({
    this.recommendedIng,
    this.message,
  });

  List<IngredientShop>? recommendedIng;
  String? message;

  factory Recomended.fromJson(Map<String, dynamic> json) => Recomended(
        recommendedIng: List<IngredientShop>.from(json["data"].map((x) => IngredientShop.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(recommendedIng!.map((x) => x.toJson())),
        "message": message,
      };
}

// To parse this JSON data, do
//
//     final recipeDetails = recipeDetailsFromJson(jsonString);

import 'dart:convert';

import 'Recipe.dart';

RecipeDetails recipeDetailsFromJson(String str) => RecipeDetails.fromJson(json.decode(str));

String recipeDetailsToJson(RecipeDetails data) => json.encode(data.toJson());

class RecipeDetails {
  RecipeDetails({
    required this.recipe,
    required this.recomended,
    required this.message,
  });

  Recipe recipe;
  Recomended recomended;
  String message;

  factory RecipeDetails.fromJson(Map<String, dynamic> json) => RecipeDetails(
        recipe: Recipe.fromJson(json["data"]),
        recomended: Recomended.fromJson(json["recomended"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": recipe.toJson(),
        "recomended": recomended.toJson(),
        "message": message,
      };
}

class Recomended {
  Recomended({
    required this.recommendedRecipes,
    required this.message,
  });

  List<Recipe> recommendedRecipes;
  String message;

  factory Recomended.fromJson(Map<String, dynamic> json) => Recomended(
        recommendedRecipes: List<Recipe>.from(json["data"].map((x) => Recipe.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(recommendedRecipes.map((x) => x.toJson())),
        "message": message,
      };
}

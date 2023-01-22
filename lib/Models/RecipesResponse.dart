// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

import 'package:co_chef_mobile/Constants/ApiRoutes.dart';
import 'package:co_chef_mobile/Models/Recipe.dart';

RecipesResponse responseFromJson(String str) => RecipesResponse.fromJson(json.decode(str));

String responseToJson(RecipesResponse data) => json.encode(data.toJson());

class RecipesResponse {
  RecipesResponse({
    this.data,
  });

  RecipesData? data;

  factory RecipesResponse.fromJson(Map<String, dynamic> json) => RecipesResponse(
        data: RecipesData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class RecipesData {
  RecipesData({
    this.recipes,
    this.recomendedUsers,
    this.recomendedRecipes,
    this.message,
  });

  Recipes? recipes;
  List<RecomendedUser>? recomendedUsers;
  String? recomendedRecipes;
  String? message;

  factory RecipesData.fromJson(Map<String, dynamic> json) => RecipesData(
        recipes: Recipes.fromJson(json["recipes"]),
        recomendedUsers: List<RecomendedUser>.from(json["recomendedUsers"].map((x) => RecomendedUser.fromJson(x))),
        recomendedRecipes: json["recomendedRecipes"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "recipes": recipes!.toJson(),
        "recomendedUsers": List<dynamic>.from(recomendedUsers!.map((x) => x.toJson())),
        "recomendedRecipes": recomendedRecipes,
        "message": message,
      };
}

class Recipes {
  Recipes({
    this.recipes,
    this.message,
  });

  List<Recipe>? recipes;
  String? message;

  factory Recipes.fromJson(Map<String, dynamic> json) => Recipes(
        recipes: List<Recipe>.from(json["data"].map((x) => Recipe.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(recipes!.map((x) => x.toJson())),
        "message": message,
      };
}

class Ingredient {
  Ingredient(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.calories,
      this.deleted,
      this.ingredientCategoryId,
      this.amountId,
      this.createdAt,
      this.updatedAt,
      this.quantity,
      this.pivot,
      this.amount,
      this.isFavorite});

  int? id;
  String? name;
  String? image;
  int? price;
  int? calories;
  int? deleted;
  int? ingredientCategoryId;
  int? amountId;
  String? createdAt;
  String? updatedAt;
  var quantity;
  Pivot? pivot;
  Amount? amount;
  bool? isFavorite;

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
      id: json["id"],
      name: json["name"],
      image: (baseUrl + '/' + json["image"]).replaceAll('public', 'storage'),
      price: json["price"],
      calories: json["calories"],
      deleted: json["deleted"],
      ingredientCategoryId: json["ingredient_category_id"],
      amountId: json["amount_id"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      quantity: json["quantity"],
      pivot: Pivot.fromJson(json["pivot"]),
      amount: Amount.fromJson(json["amount"]),
      isFavorite: json["is_favorite"] == 0 ? false : true);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "calories": calories,
        "deleted": deleted,
        "ingredient_category_id": ingredientCategoryId,
        "amount_id": amountId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "quantity": quantity,
        "pivot": pivot!.toJson(),
        "amount": amount!.toJson(),
      };
}

class Amount {
  Amount({
    this.id,
    this.value,
    this.unit,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? value;
  String? unit;
  String? createdAt;
  String? updatedAt;

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        id: json["id"],
        value: json["value"],
        unit: json["unit"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "unit": unit,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Pivot {
  Pivot({
    this.recipeId,
    this.ingredientId,
    this.quantity,
  });

  int? recipeId;
  int? ingredientId;
  var quantity;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        recipeId: json["recipe_id"],
        ingredientId: json["ingredient_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "recipe_id": recipeId,
        "ingredient_id": ingredientId,
        "quantity": quantity,
      };
}

class RecomendedUser {
  RecomendedUser({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory RecomendedUser.fromJson(Map<String, dynamic> json) => RecomendedUser(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

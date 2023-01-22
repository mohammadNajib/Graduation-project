import 'package:co_chef_mobile/Models/RecipesResponse.dart';
import 'package:co_chef_mobile/Models/Tag.dart';
import 'package:co_chef_mobile/Constants/ApiRoutes.dart';

class Recipe {
  Recipe(
      {this.id,
      this.name,
      this.image,
      this.sharesNumber,
      this.preparationTime,
      this.howToPrepare,
      this.state,
      this.price,
      this.calories,
      this.rating,
      this.category,
      this.tags,
      this.ingredients,
      this.authorName,
      this.authorId,
      this.myRating,
      this.isFavorite});

  int? id;
  String? name;
  String? image;
  int? sharesNumber;
  int? preparationTime;
  String? howToPrepare;
  String? state;
  var price;
  var calories;
  String? category;
  var rating;
  List<Tag>? tags;
  List<Ingredient>? ingredients;
  String? authorName;
  int? authorId;
  int? myRating;
  bool? isFavorite;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
      id: json["id"],
      name: json["name"],
      image: baseUrl + '/' + json["image"],
      sharesNumber: json["shares_number"],
      preparationTime: json["preparation_time"],
      howToPrepare: json["how_to_prepare"],
      state: json["state"],
      price: json["price"],
      calories: json["calories"],
      rating: json["rating"],
      category: json["category"],
      tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      ingredients: List<Ingredient>.from(json["ingredients"].map((x) => Ingredient.fromJson(x))),
      authorName: json["user"]["name"],
      authorId: json["user"]["id"],
      myRating: json["my_rating"],
      isFavorite: json["is_favorite"] == 0 ? false : true);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "shares_number": sharesNumber,
        "preparation_time": preparationTime,
        "how_to_prepare": howToPrepare,
        "state": state,
        "price": price,
        "calories": calories,
        "rating": rating,
        "category": category,
        "tags": List<Tag>.from(tags!.map((x) => x)),
        "ingredients": List<Tag>.from(ingredients!.map((x) => x.toJson())),
      };
}

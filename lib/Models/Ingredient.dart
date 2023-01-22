import 'package:co_chef_mobile/Constants/ApiRoutes.dart';

class IngredientShop {
  IngredientShop({this.id, this.name, this.image, this.price, this.calories, this.category, this.amount, this.unit});

  int? id;
  String? name;
  String? image;
  int? price;
  int? calories;
  String? category;
  int? amount;
  String? unit;
  int orderAmount = 0;

  factory IngredientShop.fromJson(Map<String, dynamic> json) => IngredientShop(
      id: json["id"],
      name: json["name"],
      image: baseUrl + '/' + json["image"],
      price: json["price"],
      calories: json["calories"],
      category: json["category"],
      amount: json["amount"],
      unit: json["unit"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "calories": calories,
        "category": category,
        "amount": amount,
        "unit": unit
      };
}

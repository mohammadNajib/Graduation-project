// To parse this JSON data, do
//
//     final mealOrder = mealOrderFromJson(jsonString);

import 'dart:convert';

import 'package:co_chef_mobile/Constants/ApiRoutes.dart';

import 'Address/Address.dart';

MealOrder mealOrderFromJson(String str) => MealOrder.fromJson(json.decode(str));

String mealOrderToJson(MealOrder data) => json.encode(data.toJson());

class MealOrder {
  MealOrder({
    this.id,
    this.state,
    this.status,
    this.date,
    this.payment,
    this.user,
    this.userMobile,
    this.driver,
    this.address,
    this.meal,
  });

  int? id;
  String? state;
  int? status;
  DateTime? date;
  int? payment;
  User? user;
  String? userMobile;
  dynamic driver;
  Address? address;
  Meal? meal;

  factory MealOrder.fromJson(Map<String, dynamic> json) => MealOrder(
        id: json["id"],
        state: json["state"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
        payment: json["payment"],
        user: User.fromJson(json["user"]),
        userMobile: json["user_mobile"],
        driver: json["driver"],
        address: Address.fromJson(json["address"]),
        meal: Meal.fromJson(json["meal"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
        "status": status,
        "date": date!.toIso8601String(),
        "payment": payment,
        "user": user!.toJson(),
        "user_mobile": userMobile,
        "driver": driver,
        "address": address!.toJson(),
        "meal": meal!.toJson(),
      };
}

class Chef {
  Chef({
    this.id,
    this.availability,
    this.user,
  });

  int? id;
  String? availability;
  User? user;

  factory Chef.fromJson(Map<String, dynamic> json) => Chef(
        id: json["id"],
        availability: json["availability"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "availability": availability,
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.state,
    this.gender,
    this.chefId,
  });

  int? id;
  String? name;
  String? state;
  String? gender;
  int? chefId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        state: json["state"],
        gender: json["gender"],
        chefId: json["chef_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state": state,
        "gender": gender,
        "chef_id": chefId,
      };
}

class Meal {
  Meal(
      {this.id,
      this.name,
      this.image,
      this.preparationTime,
      this.price,
      this.description,
      this.rating,
      this.category,
      this.tags,
      this.chef,
      this.myRating});

  int? id;
  String? name;
  String? image;
  int? preparationTime;
  int? price;
  String? description;
  int? rating;
  String? category;
  List<Tag>? tags;
  Chef? chef;
  int? myRating;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
      id: json["id"],
      name: json["name"],
      image: baseUrl + '/' + json["image"],
      preparationTime: json["preparation_time"],
      price: json["price"],
      description: json["description"],
      rating: json["rating"],
      category: json["category"],
      tags: List<Tag>.from(json["tags"].map((x) => x)),
      chef: Chef.fromJson(json["chef"]),
      myRating: json["my_rating"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "preparation_time": preparationTime,
        "price": price,
        "description": description,
        "rating": rating,
        "category": category,
        "tags": List<dynamic>.from(tags!.map((x) => x)),
      };
}

class Tag {
  Tag({this.id, this.name});

  int? id;
  String? name;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
      );
}

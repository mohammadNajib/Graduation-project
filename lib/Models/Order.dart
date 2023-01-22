// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

import 'package:co_chef_mobile/Constants/ApiRoutes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

OrderResponse responseFromJson(String str) => OrderResponse.fromJson(json.decode(str));

String responseToJson(OrderResponse data) => json.encode(data.toJson());

DateFormat formatter = DateFormat('yyyy-MM-dd');

class OrderResponse {
  OrderResponse({
    this.data,
    this.message,
  });

  List<Order>? data;
  String? message;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        data: List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Order {
  Order({
    this.id,
    this.state,
    this.status,
    this.date,
    this.payment,
    this.rating,
    this.notes,
    this.user,
    this.userMobile,
    this.driver,
    this.address,
    this.ingredients,
    this.market,
  });

  int? id;
  String? state;
  int? status;
  String? date;
  int? payment;
  int? rating;
  String? notes;
  User? user;
  String? userMobile;
  Driver? driver;
  Address? address;
  List<Ingredient>? ingredients;
  String? market;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        state: json["state"],
        status: json["status"],
        date: formatter.format(DateTime.parse(json["date"])).toString(),
        payment: json["payment"],
        rating: json["rating"],
        notes: json["notes"],
        user: User.fromJson(json["user"]),
        userMobile: json["user_mobile"],
        driver: (json["driver"] == null) ? null : Driver.fromJson(json["driver"]),
        address: Address.fromJson(json["address"]),
        ingredients: List<Ingredient>.from(json["ingredients"].map((x) => Ingredient.fromJson(x))),
        market: json["market"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
        "status": status,
        "date": date,
        "payment": payment,
        "rating": rating,
        "user": user!.toJson(),
        "user_mobile": userMobile,
        "driver": driver,
        "address": address!.toJson(),
        "ingredients": List<dynamic>.from(ingredients!.map((x) => x.toJson())),
        "market": market,
      };

  String getstate() {
    if (state == "pending")
      return "بالانتظار";
    else if (state == "rejected")
      return "مرفوضة";
    else if (state == "accepted by driver")
      return "جاري التوصيل";
    else if (state == "delivered")
      return "تم التوصيل";
    else
      return "بالانتظار";
  }

  IconData getIcon() {
    if (state == "pending")
      return Icons.timer;
    else if (state == "rejected")
      return Icons.close;
    else if (state == "accepted by driver")
      return Icons.check;
    else if (state == "delivered")
      return Icons.check;
    else
      return Icons.timer;
  }
}

class Address {
  Address({
    this.id,
    this.name,
    this.city,
    this.area,
    this.subarea,
    this.floor,
    this.details,
    this.gpsLongitude,
    this.gpsLatitude,
  });

  int? id;
  String? name;
  String? city;
  String? area;
  String? subarea;
  int? floor;
  String? details;
  dynamic gpsLongitude;
  dynamic gpsLatitude;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        area: json["area"],
        subarea: json["subarea"],
        floor: json["floor"],
        details: json["details"],
        gpsLongitude: json["gps_longitude"],
        gpsLatitude: json["gps_latitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "area": area,
        "subarea": subarea,
        "floor": floor,
        "details": details,
        "gps_longitude": gpsLongitude,
        "gps_latitude": gpsLatitude,
      };
}

class Ingredient {
  Ingredient({
    this.id,
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
  });

  int? id;
  String? name;
  String? image;
  int? price;
  int? calories;
  int? deleted;
  int? ingredientCategoryId;
  int? amountId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? quantity;
  Pivot? pivot;
  Amount? amount;

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        name: json["name"],
        image: (baseUrl + json["image"]).replaceAll('public', '/storage'),
        price: json["price"],
        calories: json["calories"],
        deleted: json["deleted"],
        ingredientCategoryId: json["ingredient_category_id"],
        amountId: json["amount_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        quantity: json["quantity"],
        pivot: Pivot.fromJson(json["pivot"]),
        amount: Amount.fromJson(json["amount"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "calories": calories,
        "deleted": deleted,
        "ingredient_category_id": ingredientCategoryId,
        "amount_id": amountId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
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
    this.ingredientsOrderId,
    this.ingredientId,
    this.quantity,
    this.price,
    this.marketId,
  });

  int? ingredientsOrderId;
  int? ingredientId;
  int? quantity;
  int? price;
  int? marketId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        ingredientsOrderId: json["ingredients_order_id"],
        ingredientId: json["ingredient_id"],
        quantity: json["quantity"],
        price: json["price"],
        marketId: json["market_id"],
      );

  Map<String, dynamic> toJson() => {
        "ingredients_order_id": ingredientsOrderId,
        "ingredient_id": ingredientId,
        "quantity": quantity,
        "price": price,
        "market_id": marketId,
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

class Driver {
  Driver({this.id, this.name, this.mobile});
  int? id;
  String? name;
  String? mobile;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

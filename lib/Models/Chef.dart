// To parse this JSON data, do
//
//     final chef = chefFromJson(jsonString);

import 'dart:convert';

Chef chefFromJson(String str) => Chef.fromJson(json.decode(str));

String chefToJson(Chef data) => json.encode(data.toJson());

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

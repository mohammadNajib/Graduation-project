// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

AddressResponse responseFromJson(String str) => AddressResponse.fromJson(json.decode(str));

String responseToJson(AddressResponse data) => json.encode(data.toJson());

class AddressResponse {
  AddressResponse({required this.data, required this.message});

  List<City> data;
  String message;

  factory AddressResponse.fromJson(Map<String, dynamic> json) => AddressResponse(
        data: List<City>.from(json["data"].map((x) => City.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class City {
  City({
    this.id,
    this.name,
    this.areas,
  });

  int? id;
  String? name;
  List<Area>? areas;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        areas: List<Area>.from(json["areas"].map((x) => Area.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "areas": List<dynamic>.from(areas!.map((x) => x.toJson())),
      };
}

class Area {
  Area({
    this.id,
    this.name,
    this.subareas,
  });

  int? id;
  String? name;
  List<Subarea>? subareas;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
        subareas: List<Subarea>.from(json["subareas"].map((x) => Subarea.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subareas": List<dynamic>.from(subareas!.map((x) => x.toJson())),
      };
}

class Subarea {
  Subarea({
    this.id,
    this.name,
    this.city,
    this.area,
  });

  int? id;
  String? name;
  CityClass? city;
  CityClass? area;

  factory Subarea.fromJson(Map<String, dynamic> json) => Subarea(
        id: json["id"],
        name: json["name"],
        city: CityClass.fromJson(json["city"]),
        area: CityClass.fromJson(json["area"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city!.toJson(),
        "area": area!.toJson(),
      };
}

class CityClass {
  CityClass({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory CityClass.fromJson(Map<String, dynamic> json) => CityClass(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

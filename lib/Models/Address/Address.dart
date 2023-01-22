// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

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

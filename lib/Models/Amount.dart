class Amount {
  int? id;
  int? value;
  String? unit;
  Amount({this.id, this.value, this.unit});

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        id: json["id"],
        value: json["value"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "unit": unit,
      };
}

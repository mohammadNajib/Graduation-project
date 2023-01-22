class IngredientCategory {
  int id;
  String name;

  IngredientCategory({
    required this.id,
    required this.name,
  });

  factory IngredientCategory.fromJson(Map<String, dynamic> json) => IngredientCategory(
        id: json["id"],
        name: json["name"],
      );
}

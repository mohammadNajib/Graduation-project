class RecipeCategory {
  int id;
  String? name;

  RecipeCategory({
    required this.id,
    this.name,
  });

  factory RecipeCategory.fromJson(Map<String, dynamic> json) => RecipeCategory(
        id: json["id"],
        name: json["name"],
      );
}

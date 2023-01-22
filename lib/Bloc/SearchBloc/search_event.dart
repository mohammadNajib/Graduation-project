part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchName extends SearchEvent {
  final String name;

  SearchName(this.name);
}

class SearchRecipes extends SearchEvent {
  final String price;
  final String minCalories;
  final String maxCalories;
  final String preperationTime;
  final String rating;
  final String category;

  SearchRecipes(this.price, this.minCalories, this.maxCalories,
      this.preperationTime, this.rating, this.category);
}

class SearchMeals extends SearchEvent {
  final String price;
  final String minCalories;
  final String maxCalories;
  final String preperationTime;
  final String rating;
  final String category;

  SearchMeals(this.price, this.minCalories, this.maxCalories,
      this.preperationTime, this.rating, this.category);
}

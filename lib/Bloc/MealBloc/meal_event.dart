part of 'meal_bloc.dart';

@immutable
abstract class MealEvent {}

class MealsFetch extends MealEvent {}

class MealAddRating extends MealEvent {
  final int id;
  final rating;
  MealAddRating(this.id, this.rating);
}

class MealOrderMeal extends MealEvent {
  final Meal meal;
  final int addressId;
  MealOrderMeal(this.meal, this.addressId);
}

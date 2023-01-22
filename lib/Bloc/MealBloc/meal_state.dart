part of 'meal_bloc.dart';

@immutable
abstract class MealState {}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealDone extends MealState {
  final List<Meal> meals;

  MealDone(this.meals);
}

class MealFailed extends MealState {}

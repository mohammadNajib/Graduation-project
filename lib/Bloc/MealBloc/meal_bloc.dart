import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:co_chef_mobile/Models/MealOrder.dart';
import 'package:co_chef_mobile/Repositories/mealRepo.dart';
import 'package:meta/meta.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  MealBloc() : super(MealInitial());

  MealRepo mealRepo = MealRepo();
  @override
  Stream<MealState> mapEventToState(
    MealEvent event,
  ) async* {
    if (event is MealsFetch) {
      yield MealLoading();
      List<Meal> meals = await mealRepo.getMeals();
      yield MealDone(meals);
    } else if (event is MealAddRating) {
      await mealRepo.addRating(event.id, event.rating);
    } else if (event is MealOrderMeal) {
      await mealRepo.orderMeal(event.meal, event.addressId);
    }
  }
}

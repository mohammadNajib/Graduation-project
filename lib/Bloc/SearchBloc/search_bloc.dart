import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:co_chef_mobile/Repositories/SearchRepo.dart';
import 'package:meta/meta.dart';

import '../../Models/MealOrder.dart';
import '../../Models/Recipe.dart';
import '../../Models/otherUsers.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchDone());

  SearchRepo searchRepo = SearchRepo();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchName) {
      yield SearchLoading();
      List<OtherProfile> users = await searchRepo.searchName(event.name);
      yield SearchDone(users: users);
    } else if (event is SearchRecipes) {
      yield SearchLoading();
      List<Recipe> recipes = await searchRepo.filterRecipes(
          price: event.price,
          category: event.category,
          maxCalories: event.maxCalories,
          minCalories: event.minCalories,
          preperationTime: event.preperationTime,
          rating: event.rating);
      yield SearchDone(recipes: recipes);
    } else if (event is SearchMeals) {
      yield SearchLoading();
      List<Recipe> recipes = await searchRepo.filterMeals(
          price: event.price,
          category: event.category,
          maxCalories: event.maxCalories,
          minCalories: event.minCalories,
          preperationTime: event.preperationTime,
          rating: event.rating);
      yield SearchDone(recipes: recipes);
    }
  }
}

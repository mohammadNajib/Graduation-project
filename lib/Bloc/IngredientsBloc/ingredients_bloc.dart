import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:co_chef_mobile/Models/ingredientsCategory.dart';
import 'package:co_chef_mobile/Repositories/IngredientsRepo.dart';
import 'package:meta/meta.dart';

import '../../Models/Ingredient.dart';

part 'ingredients_event.dart';
part 'ingredients_state.dart';

class IngredientsBloc extends Bloc<IngredientsEvent, IngredientsState> {
  IngredientsBloc() : super(IngredientsInitial());

  IngredientRepo ingredientCategoryRepo = IngredientRepo();
  @override
  Stream<IngredientsState> mapEventToState(
    IngredientsEvent event,
  ) async* {
    if (event is IngredientsGetCategories) {
      yield IngredientsLoading();
      // bool result = await InternetConnectionChecker().hasConnection;
      // if (result == true) {
      var categories = await ingredientCategoryRepo.loadCategories();
      yield IngredientsFetchingDone(dataList: categories);
      // } else {
      // yield IngredientsNoInternet();
      // }
    } else if (event is IngredientsGetDetails) {
      yield IngredientsLoading();
      // bool result = await InternetConnectionChecker().hasConnection;
      // if (result == true) {
      var ingredients = await ingredientCategoryRepo.loadIngrdientsByCategoryId(event.id);
      yield IngredientsFetchingDone(ingredientShop: ingredients);
      // } else {
      //   yield IngredientsNoInternet();
      // }
    } else if (event is IngredientsGetAll) {
      yield IngredientsLoading();
      var ingredients = await ingredientCategoryRepo.loadIngrdients();
      yield IngredientsFetchingDone(ingredientShop: ingredients);
    }
  }
}

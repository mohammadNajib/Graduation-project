part of 'ingredients_bloc.dart';

@immutable
abstract class IngredientsState {}

class IngredientsInitial extends IngredientsState {}

class IngredientsNoInternet extends IngredientsState {}

class IngredientsLoading extends IngredientsState {}

class IngredientsFetchingDone extends IngredientsState {
  final List<IngredientCategory>? dataList;
  final List<IngredientShop>? ingredientShop;

  IngredientsFetchingDone({this.dataList, this.ingredientShop});
}

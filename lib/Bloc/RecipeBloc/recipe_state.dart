part of 'recipe_bloc.dart';

@immutable
abstract class RecipeState {}

class RecipeInitial extends RecipeState {}

class RecipeNoInternet extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeFetchingDone extends RecipeState {
  final RecipesData? data;
  final List<Recipe>? recipes;

  RecipeFetchingDone({this.recipes, this.data});
}

class RecipeAddRecipeFailed extends RecipeState {
  final String message;

  RecipeAddRecipeFailed(this.message);
}

class RecipeAddRecipeDone extends RecipeState {}

class RecipeDetailsDone extends RecipeState {
  final RecipeDetails recipeDetails;

  RecipeDetailsDone(this.recipeDetails);
}

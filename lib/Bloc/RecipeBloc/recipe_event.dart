part of 'recipe_bloc.dart';

@immutable
abstract class RecipeEvent {}

class RecipeGettAll extends RecipeEvent {}

class RecipeGetDetailes extends RecipeEvent {
  final int id;

  RecipeGetDetailes(this.id);
}

class RecipeGetPersonalRecipes extends RecipeEvent {}

class RecipeAddRecipe extends RecipeEvent {
  final String name;
  final int sharesNumber;
  final int preparationTime;
  final String howToPrepare;
  final bool ispublic;
  final int recipeCategoryId;
  final List<IngredientShop> ingredients;
  final String image;

  RecipeAddRecipe(
      this.name,
      this.sharesNumber,
      this.preparationTime,
      this.howToPrepare,
      this.ispublic,
      this.recipeCategoryId,
      this.ingredients,
      this.image);
}

class RecipeGetDetails extends RecipeEvent {
  final int recipeId;

  RecipeGetDetails(this.recipeId);
}

class RecipeGetDone extends RecipeEvent {
  final int recipeId;

  RecipeGetDone(this.recipeId);
}

class RecipeGetFavortieRecipes extends RecipeEvent {}

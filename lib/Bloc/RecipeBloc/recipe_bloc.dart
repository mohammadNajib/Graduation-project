import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:co_chef_mobile/Models/Ingredient.dart';
import 'package:co_chef_mobile/Models/Recipe.dart';
import 'package:co_chef_mobile/Models/RecipeDetails.dart';
import 'package:co_chef_mobile/Models/RecipesResponse.dart';
import 'package:co_chef_mobile/Repositories/recipeRepo.dart';
import 'package:meta/meta.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(RecipeInitial());

  RecipeRepo recipeRepo = RecipeRepo();
  @override
  Stream<RecipeState> mapEventToState(
    RecipeEvent event,
  ) async* {
    if (event is RecipeGettAll) {
      yield RecipeLoading();
      // bool result = await InternetConnectionChecker().hasConnection;

      // if (result == true) {
      var recipes = await recipeRepo.loadRecipes();
      yield RecipeFetchingDone(data: recipes);
      // } else {
      // yield RecipeNoInternet();
      // }
    } else if (event is RecipeGetPersonalRecipes) {
      yield RecipeLoading();
      var recipes = await recipeRepo.loadPersonalRecipes();
      yield RecipeFetchingDone(recipes: recipes);
    } else if (event is RecipeAddRecipe) {
      if (event.name == '')
        yield RecipeAddRecipeFailed('الرجاء ادخال اسم');
      else if (event.preparationTime == 0)
        yield RecipeAddRecipeFailed('الرجاء ادخال مدة التحضير');
      else if (event.sharesNumber == 0)
        yield RecipeAddRecipeFailed('الرجاء ادخال عدد الحصص');
      else if (event.howToPrepare == '')
        yield RecipeAddRecipeFailed('الرجاء ادخال طريقة التحضير');
      else if (event.recipeCategoryId == -1)
        yield RecipeAddRecipeFailed('الرجاء اختيار صنف الطبق');
      else {
        yield RecipeLoading();
        bool result = await recipeRepo.addRecipe(event.name, event.sharesNumber, event.preparationTime,
            event.howToPrepare, event.ispublic, event.recipeCategoryId, event.ingredients, event.image);
        if (result)
          yield RecipeAddRecipeDone();
        else
          yield RecipeAddRecipeFailed('لم يتم انشاء الوصفة');

        // yield Recipe
      }
    } else if (event is RecipeGetDetailes) {
      yield RecipeLoading();
      RecipeDetails details = await recipeRepo.getRecipeDetails(event.id);
      yield RecipeDetailsDone(details);
    } else if (event is RecipeGetFavortieRecipes) {
      yield RecipeLoading();
      var recipes = await recipeRepo.getFavoriteRecipes();
      yield RecipeFetchingDone(recipes: recipes);
    }
  }
}

import 'package:co_chef_mobile/Models/ApiResponse.dart';
import 'package:co_chef_mobile/Models/Ingredient.dart';
import 'package:co_chef_mobile/Models/Recipe.dart';
import 'package:co_chef_mobile/Models/RecipeDetails.dart';
import 'package:co_chef_mobile/Models/RecipesResponse.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';
import 'package:dio/dio.dart';
import 'package:co_chef_mobile/Constants/ApiRoutes.dart' as ApiRoutes;

class RecipeRepo {
  UserRepo userRepo = UserRepo();

  loadRecipes() async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    try {
      res = await dio.get(ApiRoutes.getRecipes, options: Options(headers: headers));
      RecipesResponse response = RecipesResponse.fromJson(res.data);
      return response.data;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return [];
    } catch (e) {
      return [];
    }
  }

  loadPersonalRecipes() async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    List<Recipe> recipes = [];
    try {
      res = await dio.get(ApiRoutes.getPersonalRecipes, options: Options(headers: headers));
      ApiResponse apiResponse = ApiResponse.fromJson(res.data);
      for (var i = 0; i < apiResponse.data.length; i++) {
        recipes.add(Recipe.fromJson(apiResponse.data[i]));
      }
      return recipes;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return recipes;
    } catch (e) {
      return recipes;
    }
  }

  addRecipe(String name, int sharesNumber, int preparationTime, String howToPrepare, bool ispublic,
      int recipeCategoryId, List<IngredientShop> ingredients, String image) async {
    Dio dio = Dio();
    Response res;
    var headers = {'Authorization': 'Bearer ${userRepo.token}', 'Content-Type': 'multipart/form-data', 'Accept': '*/*'};
    // Map body = {
    //   'name': name,
    //   'shares_number': sharesNumber.toString(),
    //   'preparation_time': preparationTime.toString(),
    //   'how_to_prepare': howToPrepare,
    //   'is_public': ispublic ? '1' : '0',
    //   'recipe_category_id': recipeCategoryId.toString(),
    //   'image': MultipartFile.fromFile(image)
    // };
    // for (int i = 0; i < ingredients.length; i++) {
    //   body['ingredients[$i][ingredient_id]'] = ingredients[i].id;
    //   body['ingredients[$i][quantity]'] = ingredients[i].amount;
    // }
    var data = FormData();
    data.fields.add(MapEntry('name', name));
    data.fields.add(MapEntry('shares_number', sharesNumber.toString()));
    data.fields.add(MapEntry('preparation_time', preparationTime.toString()));
    data.fields.add(MapEntry('how_to_prepare', howToPrepare));
    data.fields.add(MapEntry('is_public', ispublic ? '1' : '0'));
    data.fields.add(MapEntry('recipe_category_id', recipeCategoryId.toString()));
    for (int i = 0; i < ingredients.length; i++) {
      data.fields.add(MapEntry('ingredients[$i][ingredient_id]', ingredients[i].id.toString()));
      data.fields.add(MapEntry('ingredients[$i][quantity]', ingredients[i].orderAmount.toString()));
    }
    if (image.isNotEmpty) data.files.add(MapEntry('image', await MultipartFile.fromFile(image)));
    try {
      res = await dio.post(ApiRoutes.addNewRecipe, options: Options(headers: headers), data: data);
      ApiResponse apiResponse = ApiResponse.fromJson(res.data);
      print(apiResponse.data);
      if (apiResponse.message == 'Item Created') {
        return true;
      } else
        return false;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getFavoriteRecipes() async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    List<Recipe> recipes = [];
    try {
      res = await dio.get(ApiRoutes.getFavoriteRecipes, options: Options(headers: headers));
      ApiResponse apiResponse = ApiResponse.fromJson(res.data);
      for (var i = 0; i < apiResponse.data.length; i++) {
        recipes.add(Recipe.fromJson(apiResponse.data[i]));
      }
      return recipes;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return recipes;
    } catch (e) {
      return recipes;
    }
  }

  addToFavorite(int id) async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    var body = {'recipe_id': '$id'};
    Response res;
    try {
      res = await dio.post(ApiRoutes.addToFavortie, options: Options(headers: headers), data: body);
      ApiResponse response = ApiResponse.fromJson(res.data);
      print(response.message);
      return response.data;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    } catch (e) {
      return [];
    }
  }

  removeFromFavorite(int id) async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    var body = {'recipe_id': '$id'};
    Response res;
    try {
      res = await dio.post(ApiRoutes.removeFromFavorite, options: Options(headers: headers), data: body);
      ApiResponse response = ApiResponse.fromJson(res.data);
      print(response.message);
      return response.data;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    } catch (e) {
      return [];
    }
  }

  void addRating(int id, var rate) async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    var body = {'recipe_id': '$id', 'rating': '$rate'};
    Response res;
    try {
      res = await dio.post(ApiRoutes.rateRecipe, options: Options(headers: headers), data: body);
      ApiResponse response = ApiResponse.fromJson(res.data);
      print(response.message);
      return response.data;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    } catch (e) {}
  }

  getRecipeDetails(int id) async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    try {
      res = await dio.get(ApiRoutes.getRecipeDetails + id.toString(), options: Options(headers: headers));
      // ApiResponse response = ApiResponse.fromJson(res.data);
      RecipeDetails recipeDetails = RecipeDetails.fromJson(res.data);

      return recipeDetails;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    } catch (e) {}
  }
}

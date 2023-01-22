import 'package:co_chef_mobile/Models/ApiResponse.dart';
import 'package:co_chef_mobile/Models/Ingredient.dart';
import 'package:co_chef_mobile/Models/IngredientDetails.dart';
import 'package:co_chef_mobile/Models/ingredientsCategory.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';
import 'package:dio/dio.dart';
import 'package:co_chef_mobile/Constants/ApiRoutes.dart' as ApiRoutes;

class IngredientRepo {
  UserRepo userRepo = UserRepo();
  List<IngredientCategory> categories = [];
  List<IngredientShop> ingredients = [];

  loadCategories() async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    // List<IngredientCategory> recipes = [];
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    try {
      res = await dio.get(ApiRoutes.getCategories,
          options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
      if (apiResponse.message == 'success') {
        categories = List<IngredientCategory>.from(
            apiResponse.data.map((x) => IngredientCategory.fromJson(x)));
        return categories;
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return categories;
    }
  }

  loadIngrdientsByCategoryId(int id) async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    // List<IngredientCategory> recipes = [];
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    try {
      res = await dio.get(
          ApiRoutes.getIngredientsByCategoryId
              .replaceAll('{id}', id.toString()),
          options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
      if (apiResponse.message == 'success') {
        ingredients = List<IngredientShop>.from(
            apiResponse.data.map((x) => IngredientShop.fromJson(x)));
        return ingredients;
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return ingredients;
    }
  }

  loadIngrdients() async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    List<IngredientShop> ingredients = [];
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    try {
      res = await dio.get(ApiRoutes.getAllIngredients,
          options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
      if (apiResponse.message == 'success') {
        ingredients = List<IngredientShop>.from(
            apiResponse.data.map((x) => IngredientShop.fromJson(x)));
        return ingredients;
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return ingredients;
    }
  }

  showIngredientDetails(int id) async {
    Dio dio = Dio();
    IngredientDetails ingredientDetails;
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    try {
      res = await dio.get(ApiRoutes.getIngredientDetails + id.toString(),
          options: Options(headers: headers));
      ingredientDetails = IngredientDetails.fromJson(res.data);
      return ingredientDetails;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    }
  }
}

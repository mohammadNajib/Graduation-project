import 'package:co_chef_mobile/Models/ApiResponse.dart';
import 'package:co_chef_mobile/Models/MealOrder.dart';
import 'package:co_chef_mobile/Models/Recipe.dart';
import 'package:co_chef_mobile/Models/otherUsers.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';
import 'package:dio/dio.dart';
import 'package:co_chef_mobile/Constants/ApiRoutes.dart' as ApiRoutes;

class SearchRepo {
  UserRepo userRepo = UserRepo();

  searchName(String name) async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    var body = {'name': name};
    Response res;
    try {
      List<OtherProfile> users = [];
      res = await dio.post(ApiRoutes.searchUser, options: Options(headers: headers), data: body);
      ApiResponse response = ApiResponse.fromJson(res.data);
      for (int i = 0; i < response.data.length; i++) {
        users.add(OtherProfile.fromJson(response.data[i]));
      }
      return users;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    } catch (e) {}
  }

  filterRecipes(
      {required String price,
      required String minCalories,
      required String maxCalories,
      required String preperationTime,
      required String rating,
      required String category}) async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    var body = {
      'min_calories': minCalories,
      'max_calories': maxCalories,
      'price': price,
      'category': category,
      'preparation_time': preperationTime,
      'rating': rating == '-1' ? null : rating,
    };
    Response res;
    try {
      List<Recipe> recipes = [];
      res = await dio.post(ApiRoutes.filterRecipes, options: Options(headers: headers), data: body);
      ApiResponse response = ApiResponse.fromJson(res.data);
      for (int i = 0; i < response.data.length; i++) {
        recipes.add(Recipe.fromJson(response.data[i]));
      }

      return recipes;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    } catch (e) {}
  }

  filterMeals(
      {required String price,
      required String category,
      required String maxCalories,
      required String minCalories,
      required String preperationTime,
      required String rating}) async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    var body = {
      'min_calories': minCalories,
      'max_calories': maxCalories,
      'price': price,
      'category': category,
      'preparation_time': preperationTime,
      'rating': rating == '-1' ? null : rating,
    };
    Response res;
    try {
      List<Meal> meals = [];
      res = await dio.post(ApiRoutes.filterMeals, options: Options(headers: headers), data: body);
      ApiResponse response = ApiResponse.fromJson(res.data);
      for (int i = 0; i < response.data.length; i++) {
        meals.add(Meal.fromJson(response.data[i]));
      }
      return meals;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    } catch (e) {}
  }
}

import 'package:co_chef_mobile/Models/ApiResponse.dart';
import 'package:co_chef_mobile/Models/MealOrder.dart';
import 'package:co_chef_mobile/Models/MealResponse.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';
import 'package:dio/dio.dart';
import 'package:co_chef_mobile/Constants/ApiRoutes.dart' as ApiRoutes;

class MealRepo {
  UserRepo userRepo = UserRepo();

  getMeals() async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    try {
      res = await dio.get(ApiRoutes.getMeals, options: Options(headers: headers));
      MealResponse response = MealResponse.fromJson(res.data);
      return response.meals;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> addRating(int id, var rate) async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    var body = {'meal_id': '$id', 'rating': '$rate'};
    Response res;
    try {
      res = await dio.post(ApiRoutes.rateMeal, options: Options(headers: headers), data: body);
      ApiResponse response = ApiResponse.fromJson(res.data);
      print(response.message);
      return response.data;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    } catch (e) {}
  }

  orderMeal(Meal meal, int addressId) async {
    Dio dio = Dio();
    var headers = {
      'Authorization': 'Bearer ${userRepo.token}',
      'Content-Type': 'multipart/form-data',
    };
    FormData data = FormData();
    data.fields.add(MapEntry('payment', '${meal.price}'));
    data.fields.add(MapEntry('address_id', '$addressId'));
    data.fields.add(MapEntry('meal_id', '${meal.id}'));
    data.fields.add(MapEntry('chef_id', '${meal.chef!.id}'));
    Response res;
    try {
      res = await dio.post(ApiRoutes.orderMeal, options: Options(headers: headers), data: data);
      ApiResponse response = ApiResponse.fromJson(res.data);
      print(response.message);
      return response.data;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    } catch (e) {}
  }
}

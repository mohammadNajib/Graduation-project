import 'package:co_chef_mobile/Models/ApiResponse.dart';
import 'package:co_chef_mobile/Models/MealOrder.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';
import 'package:dio/dio.dart';
import 'package:co_chef_mobile/Constants/ApiRoutes.dart' as ApiRoutes;

class ChefRepo {
  static final ChefRepo _singleton = ChefRepo._internal();

  factory ChefRepo() {
    return _singleton;
  }

  ChefRepo._internal();

  UserRepo userRepo = UserRepo();

  bool isActive = false;

  List<MealOrder> orders = [];

  getMealOrders() async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    Response res;
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    orders.clear();
    try {
      res = await dio.get(ApiRoutes.getMealOrders, options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
      for (var i = 0; i < apiResponse.data.length; i++) {
        orders.add(MealOrder.fromJson(apiResponse.data[i]));
      }
      return orders;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return [];
    }
  }

  rejectOrder(int id) async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    var body = {'state': 'rejected'};

    try {
      await dio.put(ApiRoutes.rejectOrAcceptMealOrder + id.toString(), options: Options(headers: headers), data: body);
      orders.removeWhere((element) => element.id == id);
      return orders;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return [];
    }
  }

  acceptOrder(int id) async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    var body = {'state': 'rejected'};

    try {
      await dio.put(ApiRoutes.rejectOrAcceptMealOrder + id.toString(), options: Options(headers: headers), data: body);
      return orders;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return [];
    }
  }

  changeState() async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}', 'Accept': '*/*'};
    print('isActive :  $isActive');
    try {
      await dio.put(ApiRoutes.changeChefState, options: Options(headers: headers));
      isActive = !isActive;
      print('isActive :  $isActive');
      return orders;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return [];
    }
  }

  addMeal(String name, String price, String sharesNumber, String preparationTime, String howToPrepare,
      String mealCategoryId, String image) async {
    Dio dio = Dio();
    Response res;
    var headers = {'Authorization': 'Bearer ${userRepo.token}', 'Content-Type': 'multipart/form-data', 'Accept': '*/*'};
    var data = FormData();
    data.fields.add(MapEntry('name', name));
    data.fields.add(MapEntry('price', price.toString()));
    data.fields.add(MapEntry('shares_number', sharesNumber.toString()));
    data.fields.add(MapEntry('preparation_time', preparationTime.toString()));
    data.fields.add(MapEntry('description', howToPrepare));
    data.fields.add(MapEntry('recipe_category_id', mealCategoryId.toString()));

    if (image.isNotEmpty) data.files.add(MapEntry('image', await MultipartFile.fromFile(image)));
    try {
      res = await dio.post(ApiRoutes.addMeal, options: Options(headers: headers), data: data);
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
}

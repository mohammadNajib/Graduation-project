import 'package:co_chef_mobile/Models/ApiResponse.dart';
import 'package:co_chef_mobile/Models/Order.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';
import 'package:dio/dio.dart';
import 'package:co_chef_mobile/Constants/ApiRoutes.dart' as ApiRoutes;

class OrderHistoryRepo {
  UserRepo userRepo = UserRepo();

  loadOrders() async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    Response res;
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};

    try {
      res = await dio.get(ApiRoutes.orderHistoryIngredients, options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
      List<Order> orders = [];
      for (var i = 0; i < apiResponse.data.length; i++) {
        orders.add(Order.fromJson(apiResponse.data[i]));
      }
      return orders;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return [];
    }
  }

  rateOrder(int id, int rating, String notes) async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Map body = {
      'rating': rating.toString(),
      'notes': notes,
    };
    try {
      await dio.put(ApiRoutes.rateOrder + id.toString(), options: Options(headers: headers), data: body);
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    }
  }

  confirmOrder(int id) async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Map body = {
      'is_meal': '0',
    };
    try {
      await dio.put(ApiRoutes.confirmDeliveredOrder + id.toString(), options: Options(headers: headers), data: body);
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    }
  }
}

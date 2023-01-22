import 'package:co_chef_mobile/Models/Address/Address.dart';
import 'package:co_chef_mobile/Models/Address/AddressResponse.dart';
import 'package:co_chef_mobile/Models/ApiResponse.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';

import 'package:dio/dio.dart';
import 'package:co_chef_mobile/Constants/ApiRoutes.dart' as ApiRoutes;

class AddressesRepo {
  late List<City> cities;

  UserRepo userRepo = UserRepo();
  loadCities() async {
    Dio dio = Dio();
    Response response;
    try {
      response = await dio.get(ApiRoutes.getAddresses);
      AddressResponse apiResponse = AddressResponse.fromJson(response.data);
      cities = apiResponse.data;
    } on Exception catch (e) {
      print('Error in loading cities');
      print(e);
    }
  }

  addAddress(
      {required String name,
      required int cityId,
      required int areaId,
      required int subareaId,
      String? floor,
      String? details,
      String? latitude,
      String? longitude}) async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    Map body = {
      "name": name,
      "city_id": cityId,
      "area_id": areaId,
      "subarea_id": subareaId,
      "floor": floor,
      "details": details,
      "gps_longitude": longitude,
      "gps_lattitude": latitude
    };

    try {
      res = await dio.post(ApiRoutes.addAddress, data: body, options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
      if (apiResponse.message == 'Item Created') {
        return 'تم انشاء العنوان';
      } else
        return 'Item Not Created';
    } on DioError catch (e) {
      print(e.response);
      return 'Error';
    }
  }

  loadPersonalAddresses() async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    List<Address> addresses = [];
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    try {
      res = await dio.get(ApiRoutes.getpersonalAddresses, options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
      if (apiResponse.message == 'success') {
        addresses = List<Address>.from(apiResponse.data.map((x) => Address.fromJson(x)));
        return addresses;
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return addresses;
    }
  }

  deleteAddress({required int id}) async {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    try {
      res = await dio.delete(ApiRoutes.deleteAddress + id.toString(), options: Options(headers: headers));
      if (res.statusCode == 200) {
        return 'تم حذف العنوان';
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return '';
    }
  }

  editAddress(
      {required int id,
      required String name,
      required int cityId,
      required int areaId,
      required int subareaId,
      required String floor,
      required String details,
      required String latitude,
      required String longitude}) async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    Map body = {
      "name": name,
      "city_id": cityId,
      "area_id": areaId,
      "subarea_id": subareaId,
      "floor": floor,
      "details": details,
      "gps_longitude": longitude,
      "gps_lattitude": latitude
    };
    try {
      print(id);
      res = await dio.put(ApiRoutes.editAddress + id.toString(), data: body, options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
      print(apiResponse.data);
      if (res.statusCode == 200) {
        return 'تم تعديل العنوان';
      }
    } on DioError {
      return '';
    }
  }
}

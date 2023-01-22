import 'package:co_chef_mobile/Models/ApiResponse.dart';
import 'package:dio/dio.dart';
import 'package:co_chef_mobile/Constants/ApiRoutes.dart' as ApiRoutes;
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  int? id;
  String? userName;
  String? token;
  String? gender;
  String? mobileNumber;
  int? chefId;
  int? followersCount;
  int? followingCount;
  int? recipeCount;

  UserRepo({
    this.id,
    this.userName,
    this.token,
    this.gender,
    this.mobileNumber,
    this.chefId,
    this.followersCount,
    this.followingCount,
    this.recipeCount,
  });

  // UserRepo();

  Future<bool> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.id = prefs.getInt('id')!;
    this.token = prefs.getString('token')!;
    this.userName = prefs.getString('userName')!;
    this.mobileNumber = prefs.getString('mobileNumber')!;
    this.gender = prefs.getString('gender')!;
    this.chefId = prefs.getInt('chef_id')!;
    this.followersCount = prefs.getInt('followersCount')!;
    this.followingCount = prefs.getInt('followingCount')!;
    this.recipeCount = prefs.getInt('recipeCount')!;

    if (this.token != null)
      return true;
    else
      return false;
  }

  void saveData(String token, String userName, int id, String mobileNumber, int chefId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', id);
    await prefs.setString('token', token);
    await prefs.setString('userName', userName);
    await prefs.setString('mobileNumber', mobileNumber);
    await prefs.setString('gender', gender!);
    await prefs.setInt('followersCount', followersCount!);
    await prefs.setInt('followingCount', followingCount!);
    await prefs.setInt('recipeCount', recipeCount!);
    await prefs.setInt('chef_id', chefId);
  }

  Future<void> deleteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    return;
  }

  Future<String> login(String number) async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    var headers = {'Content-Type': 'application/json'};
    Response res;
    try {
      print('555555555555555555555');
      res = await dio.post(ApiRoutes.loginUrl, data: {'mobile': '$number'}, options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);

      if (apiResponse.message == 'User Authenticated') {
        this.token = res.data['token'];
        res =
            await dio.get(ApiRoutes.getPersonalProfile, options: Options(headers: {'Authorization': 'Bearer $token'}));

        apiResponse = ApiResponse.fromJson(res.data);
        print(apiResponse.data);
        // print(res.data['data']);
        id = apiResponse.data['id'];
        userName = apiResponse.data['name'];
        mobileNumber = apiResponse.data['mobile'];
        gender = apiResponse.data['gender'];
        followersCount = apiResponse.data['followers_count'];
        followingCount = apiResponse.data['followings_count'];
        recipeCount = apiResponse.data['recipes_count'];
        if (apiResponse.data['chef_id'] != null) {
          chefId = apiResponse.data['chef_id'];
        }
        saveData(token!, userName!, id!, mobileNumber!, chefId!);
        return 'User Authenticated';
      } else
        return 'User Does Not Exist';
    } on Exception catch (e) {
      print(e);
    }
    return 'User Does Not Exist';
  }

  Future<String> signup(String username, String mobileNumber, String birthdate, String gender) async {
    Dio dio = Dio();
    var headers = {'Content-Type': 'application/json', "Accept": "application/json"};
    dio.options.contentType = Headers.jsonContentType;
    Response res;
    ApiResponse apiResponse;
    try {
      // print(userName + mobileNumber + birthdate + gender);
      print('===================');
      print(username);
      print(mobileNumber);
      print(birthdate);
      print(gender);
      print('===================');

      res = await dio.post(ApiRoutes.registerUrl,
          options: Options(
            headers: headers, validateStatus: (status) => true,
            // followRedirects: false,
            // validateStatus: (status) {
            //   return status < 500;
            // }
          ),
          data: {
            'name': username,
            'mobile': mobileNumber,
            'birth': birthdate,
            'gender': gender,
          });
      print(res.data);
      if (res.data['token'] != null) {
        token = res.data['token'];
        res =
            await dio.get(ApiRoutes.getPersonalProfile, options: Options(headers: {'Authorization': 'Bearer $token'}));

        apiResponse = ApiResponse.fromJson(res.data);
        id = apiResponse.data['id'];
        userName = apiResponse.data['name'];
        mobileNumber = apiResponse.data['mobile'];
        if (apiResponse.data['chef_id'] != null) {
          chefId = apiResponse.data['chef_id'];
        }
        return 'User Authenticated';
      }
      return 'User Not Authenticated';
    } catch (e) {
      print(e);
      return 'Error';
    }
  }
}

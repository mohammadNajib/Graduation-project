import 'package:co_chef_mobile/Models/ApiResponse.dart';
import 'package:co_chef_mobile/Models/otherUsers.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';
import 'package:dio/dio.dart';
import 'package:co_chef_mobile/Constants/ApiRoutes.dart' as ApiRoutes;

class FollowListsRepo {
  UserRepo userRepo = UserRepo();

  getFollowers() async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    Response res;
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    List<OtherProfile> profiles = [];

    try {
      res = await dio.get(ApiRoutes.getFollowersUrl,
          options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
      for (var i = 0; i < apiResponse.data.length; i++) {
        profiles.add(OtherProfile.fromJson(apiResponse.data[i]));
      }
      return profiles;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return profiles;
    }
  }

  getFollowing() async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    Response res;
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    List<OtherProfile> profiles = [];

    try {
      res = await dio.get(ApiRoutes.getFollowingsUrl,
          options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
      for (var i = 0; i < apiResponse.data.length; i++) {
        profiles.add(OtherProfile.fromJson(apiResponse.data[i]));
      }
      return profiles;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return profiles;
    }
  }
}

import 'package:co_chef_mobile/Models/ApiResponse.dart';
import 'package:co_chef_mobile/Models/Recipe.dart';
import 'package:co_chef_mobile/Models/otherUsers.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';
import 'package:dio/dio.dart';
import 'package:co_chef_mobile/Constants/ApiRoutes.dart' as ApiRoutes;

class OtherUsersRepo {
  UserRepo userRepo = UserRepo();

  OtherProfile otherProfile = OtherProfile();

  getProfileData(int id) async {
    Dio dio = Dio();
    Response response;
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    try {
      response = await dio.get(ApiRoutes.getUsersProfile + id.toString(), options: Options(headers: headers));
      ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      otherProfile = OtherProfile.fromJson(apiResponse.data);
      return otherProfile;
      // cities = apiResponse.data;
    } on Exception catch (e) {
      print('Error in loading other users profile');
      print(e);
    }
  }

  followUser(int userId) async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Map body = {'following_id': userId.toString()};
    Response res;
    try {
      res = await dio.post(ApiRoutes.followUser, data: body, options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
      otherProfile.isFollowing = true;
      // List recipes = await getUserRecipes(userId);
      userRepo.followingCount = userRepo.followersCount! + 1;
      return apiResponse.message;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    }
  }

  unFollowUser(int userId) async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Map body = {'following_id': userId.toString()};
    Response res;
    try {
      res = await dio.post(ApiRoutes.unFollowUser, data: body, options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
      otherProfile.isFollowing = false;
      userRepo.followingCount = userRepo.followingCount! - 1;
      return apiResponse.message;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    }
  }

  getUserRecipes(int userId) async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};
    Response res;
    List<Recipe> recipes = [];
    try {
      res = await dio.get(ApiRoutes.getOtherUserRecipe.replaceAll('{id}', userId.toString()),
          options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
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
}

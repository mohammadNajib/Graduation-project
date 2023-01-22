import 'package:co_chef_mobile/Models/ApiResponse.dart';
import 'package:co_chef_mobile/Models/RecipeCategories.dart';
import 'package:dio/dio.dart';
import 'UserRepo.dart';
import 'package:co_chef_mobile/Constants/ApiRoutes.dart' as ApiRoutes;

class RecipecategoriesRepo {
  UserRepo userRepo = UserRepo();

  getCategories() async {
    Dio dio = Dio();
    ApiResponse apiResponse;
    Response res;
    var headers = {'Authorization': 'Bearer ${userRepo.token}'};

    try {
      res = await dio.get(ApiRoutes.recipeCategories,
          options: Options(headers: headers));
      apiResponse = ApiResponse.fromJson(res.data);
      List<RecipeCategory> categories = [];
      for (var i = 0; i < apiResponse.data.length; i++) {
        categories.add(RecipeCategory.fromJson(apiResponse.data[i]));
      }
      return categories;
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
      return [];
    }
  }
}

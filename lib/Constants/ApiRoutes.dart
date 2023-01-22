// final String baseUrl = 'https://co-chef.000webhostapp.com';

final String baseUrl = 'http://192.168.43.68:8000';

final String registerUrl = baseUrl + '/api/user/register';

final String loginUrl = baseUrl + '/api/user/login';

final String getPersonalProfile = baseUrl + '/api/profile';

final String getAddresses = baseUrl + '/api/addresses';

final String addAddress = baseUrl + '/api/profile/addresses';

final String getpersonalAddresses = baseUrl + '/api/profile/addresses';

final String deleteAddress = baseUrl + '/api/profile/addresses/';

final String editAddress = baseUrl + '/api/profile/addresses/';

final String getFollowersUrl = baseUrl + '/api/profile/followers';

final String getFollowingsUrl = baseUrl + '/api/profile/followings';

final String getUsersProfile = baseUrl + '/api/profile/follow/';

final String followUser = baseUrl + '/api/profile/follow';

final String unFollowUser = baseUrl + '/api/profile/unfollow';

final String getRecipes = baseUrl + '/api/recipes';

final String getCategories = baseUrl + '/api/ingredient_categories';

final String getIngredientsByCategoryId =
    baseUrl + '/api/ingredient_categories/{id}/ingredients';

final String getPersonalRecipes = baseUrl + '/api/profile/recipes';

final String getAllIngredients = baseUrl + '/api/ingredients';

final String getIngredientDetails = baseUrl + '/api/ingredients/';

final String addNewRecipe = baseUrl + '/api/profile/recipes';

final String getOtherUserRecipe = baseUrl + '/api/profile/follow/{id}/recipes';

final String getFavoriteRecipes = baseUrl + '/api/profile/favorites';

final String addToFavortie = baseUrl + '/api/profile/favorites';

final String removeFromFavorite = baseUrl + '/api/profile/unfavorite';

final String rateRecipe = baseUrl + '/api/raterecipe';

final String orderCart = baseUrl + '/api/order_ingredients';

final String recipeCategories = baseUrl + '/api/recipe_categories';

final String orderHistoryIngredients = baseUrl + '/api/order_ingredients';

final String rateOrder = baseUrl + '/api/order_ingredients/';

final String confirmDeliveredOrder =
    baseUrl + '/api/profile/confirmDeliveredOrder/';

final String getMealOrders = baseUrl + '/api/profile/getOrders';

final String rejectOrAcceptMealOrder =
    baseUrl + '/api/profile/proccessMealOrder/';

final String changeChefState = baseUrl + '/api/profile/triggerState';

final String addMeal = baseUrl + '/api/profile/meals';

final String getRecipeDetails = baseUrl + '/api/recipes/';

final String getMeals = baseUrl + '/api/meals';

final String rateMeal = baseUrl + '/api/ratemeal';

final String orderMeal = baseUrl + '/api/order_meals';

final String searchUser = baseUrl + '/api/profile/searchUser';

final String filterRecipes = baseUrl + '/api/profile/searchRecipe';

final String filterMeals = baseUrl + '/api/profile/searchMeal';

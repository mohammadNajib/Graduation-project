import 'package:co_chef_mobile/Models/CartItem.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:co_chef_mobile/Constants/ApiRoutes.dart' as ApiRoutes;

class CartRepo {
  static final CartRepo _singleton = CartRepo._internal();

  factory CartRepo() {
    return _singleton;
  }

  CartRepo._internal();

  List<CartItem> cart = [];

  int gross = 0;

  void addToCart(CartItem cartItem) async {
    for (var i = 0; i < cart.length; i++) {
      if (cart[i].id == cartItem.id) {
        gross += cart[i].price * cartItem.orderAmount;
        cart[i].orderAmount++;

        updateStorage();
        return;
      }
    }
    cart.add(cartItem);
    gross += (cartItem.price * cartItem.orderAmount);
    updateStorage();
  }

  void removeItem(int id) {
    // cart.removeWhere((element) => element.id == id);
    gross -= cart.firstWhere((element) => element.id == id).price;
    cart.removeWhere((element) => element.id == id);
    if (cart.isEmpty) gross = 0;
    updateStorage();
  }

  void emptyCart() {
    cart.clear();
    gross = 0;
    updateStorage();
  }

  void increaseAmmount(int id) {
    CartItem temp = cart.firstWhere((element) => element.id == id);
    // temp.amount++;
    gross += temp.price;
    updateStorage();
  }

  void decreaseAmmount(int id) {
    CartItem temp = cart.firstWhere((element) => element.id == id);
    // temp.amount--;
    gross -= temp.price;
    updateStorage();
  }

  void updateStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
    await prefs.remove('cartPayment');
    await prefs.setString('cart', CartItem.encode(cart));
    await prefs.setInt('cartPayment', gross);
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var temp = prefs.getString('cart');
    if (temp != null) cart = CartItem.decode(temp);
    gross = prefs.getInt('cartPayment') ?? 0;
  }

  Future<void> orderCart(int addressId) async {
    Dio dio = Dio();
    UserRepo userRepo = UserRepo();
    var headers = {'Authorization': 'Bearer ${userRepo.token}', 'Content-Type': 'multipart/form-data', 'Accept': '*/*'};
    try {
      FormData data = FormData();
      data.fields.add(MapEntry('payment', '$gross'));
      data.fields.add(MapEntry('address_id', '$addressId'));
      for (int i = 0; i < cart.length; i++) {
        data.fields.add(MapEntry('ingredients[$i][ingredient_id]', cart[i].id.toString()));
        data.fields.add(MapEntry('ingredients[$i][quantity]', cart[i].orderAmount.toString()));
      }
      await dio.post(ApiRoutes.orderCart, data: data, options: Options(headers: headers));
      emptyCart();
    } on DioError catch (e) {
      print(e.error);
      print(e.response);
    }
  }
}

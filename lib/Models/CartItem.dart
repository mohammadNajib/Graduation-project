import 'dart:convert';

class CartItem {
  int id;
  String name;
  String image;
  int price;
  int calories;
  String category;
  int amount;
  String unit;
  int orderAmount = 1;

  CartItem(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.calories,
      required this.category,
      required this.amount,
      required this.unit,
      required this.orderAmount});

  factory CartItem.fromJson(Map<String, dynamic> jsonData) {
    return CartItem(
        id: jsonData['id'],
        name: jsonData['name'],
        image: jsonData['image'],
        price: jsonData['price'],
        calories: jsonData['calories'],
        category: jsonData['category'],
        amount: jsonData['amount'],
        unit: jsonData['unit'],
        orderAmount: jsonData['orderAmmount']);
  }

  static Map<String, dynamic> toMap(CartItem cartItem) => {
        'id': cartItem.id,
        'name': cartItem.name,
        'image': cartItem.image,
        'price': cartItem.price,
        'calories': cartItem.calories,
        'category': cartItem.category,
        'amount': cartItem.amount,
        'unit': cartItem.unit,
        'orderAmmount': cartItem.orderAmount
      };

  static String encode(List<CartItem> cart) => json.encode(
        cart.map<Map<String, dynamic>>((music) => CartItem.toMap(music)).toList(),
      );

  static List<CartItem> decode(String cart) =>
      (json.decode(cart) as List<dynamic>).map<CartItem>((item) => CartItem.fromJson(item)).toList();
}

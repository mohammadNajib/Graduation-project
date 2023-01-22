part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartGetAll extends CartEvent {}

class CartLoadData extends CartEvent {}

class CartAddItem extends CartEvent {
  final CartItem cartItem;

  CartAddItem(this.cartItem);
}

class CartRemoveItem extends CartEvent {
  final int id;

  CartRemoveItem(this.id);
}

class CartIncreaseAmmount extends CartEvent {
  final int id;

  CartIncreaseAmmount(this.id);
}

class CartDecreaseAmmount extends CartEvent {
  final int id;

  CartDecreaseAmmount(this.id);
}

class CartOrderCart extends CartEvent {
  final int addressId;

  CartOrderCart(this.addressId);
}

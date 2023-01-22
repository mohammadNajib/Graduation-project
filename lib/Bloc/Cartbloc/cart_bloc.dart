import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:co_chef_mobile/Models/CartItem.dart';
import 'package:co_chef_mobile/Repositories/CartRepo.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());

  CartRepo cartRepo = CartRepo();

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CartLoadData) {
      await cartRepo.loadData();
      if (cartRepo.cart.isEmpty)
        yield CartIsEmpty();
      else
        yield CartList(cartRepo.cart, cartRepo.gross);
    }
    if (event is CartGetAll) {
      if (cartRepo.cart.isEmpty)
        yield CartIsEmpty();
      else
        yield CartList(cartRepo.cart, cartRepo.gross);
    } else if (event is CartAddItem) {
      cartRepo.addToCart(event.cartItem);
      yield CartList(cartRepo.cart, cartRepo.gross);
    } else if (event is CartRemoveItem) {
      print('herrrrrrrrrrrrrrrrrrrrrrr');
      cartRepo.removeItem(event.id);
      if (cartRepo.cart.isEmpty)
        yield CartIsEmpty();
      else
        yield CartList(cartRepo.cart, cartRepo.gross);
    } else if (event is CartIncreaseAmmount) {
      cartRepo.increaseAmmount(event.id);
      yield CartList(cartRepo.cart, cartRepo.gross);
    } else if (event is CartDecreaseAmmount) {
      cartRepo.decreaseAmmount(event.id);
      yield CartList(cartRepo.cart, cartRepo.gross);
    } else if (event is CartOrderCart) {
      await cartRepo.orderCart(event.addressId);
      if (cartRepo.cart.isEmpty)
        yield CartIsEmpty();
      else
        yield CartList(cartRepo.cart, cartRepo.gross);
    }
  }
}

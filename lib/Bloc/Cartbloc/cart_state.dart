part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartIsEmpty extends CartState {}

class CartList extends CartState {
  final List cart;
  final int gross;

  CartList(this.cart, this.gross);
}

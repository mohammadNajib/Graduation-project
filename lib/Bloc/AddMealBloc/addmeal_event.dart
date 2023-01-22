part of 'addmeal_bloc.dart';

@immutable
abstract class AddmealEvent {}

class Addmeal extends AddmealEvent {
  final String name;
  final String price;
  final String sharesNumber;
  final String preparationTime;
  final String howToPrepare;
  final String mealCategoryId;
  final String image;

  Addmeal(this.name, this.price, this.sharesNumber, this.preparationTime,
      this.howToPrepare, this.mealCategoryId, this.image);
}

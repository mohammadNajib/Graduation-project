part of 'ingredients_bloc.dart';

@immutable
abstract class IngredientsEvent {}

class IngredientsGetCategories extends IngredientsEvent {}

class IngredientsGetDetails extends IngredientsEvent {
  final int id;

  IngredientsGetDetails(this.id);
}

class IngredientsGetAll extends IngredientsEvent {}

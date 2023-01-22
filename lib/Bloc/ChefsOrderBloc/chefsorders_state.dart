part of 'chefsorders_bloc.dart';

@immutable
abstract class ChefsordersState {}

class ChefsordersInitial extends ChefsordersState {}

class ChefsorderLoading extends ChefsordersState {}

class ChefsorderDone extends ChefsordersState {
  final List<MealOrder> mealOrder;

  ChefsorderDone(this.mealOrder);
}

class ChefsorderFailed extends ChefsordersState {}

class ChefordeUnavalibale extends ChefsordersState {}

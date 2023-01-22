part of 'addmeal_bloc.dart';

@immutable
abstract class AddmealState {}

class AddmealInitial extends AddmealState {}

class AddmealLoading extends AddmealState {}

class AddmealFailed extends AddmealState {
  final String message;

  AddmealFailed(this.message);
}

class AddmealDone extends AddmealState {}

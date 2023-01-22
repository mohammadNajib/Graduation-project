part of 'orderhistory_bloc.dart';

@immutable
abstract class OrderhistoryState {}

class OrderhistoryInitial extends OrderhistoryState {}

class OrderHistoryLoading extends OrderhistoryState {}

class OrderhistoryDone extends OrderhistoryState {
  final List<Order> orders;

  OrderhistoryDone(this.orders);
}

class OrderhistoryEmpty extends OrderhistoryState {}

class OrderhistoryFailed extends OrderhistoryState {}

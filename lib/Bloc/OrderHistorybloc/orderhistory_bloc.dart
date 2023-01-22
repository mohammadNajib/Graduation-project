import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:co_chef_mobile/Models/Order.dart';
import 'package:co_chef_mobile/Repositories/OrderHistoryRepo.dart';
import 'package:meta/meta.dart';

part 'orderhistory_event.dart';
part 'orderhistory_state.dart';

class OrderhistoryBloc extends Bloc<OrderhistoryEvent, OrderhistoryState> {
  OrderhistoryBloc() : super(OrderhistoryInitial());

  OrderHistoryRepo orderHistoryRepo = OrderHistoryRepo();
  @override
  Stream<OrderhistoryState> mapEventToState(
    OrderhistoryEvent event,
  ) async* {
    if (event is OrderhistoryFetch) {
      yield OrderHistoryLoading();
      List<Order> orders = await orderHistoryRepo.loadOrders();
      yield OrderhistoryDone(orders);
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:co_chef_mobile/Models/MealOrder.dart';
import 'package:co_chef_mobile/Repositories/ChefRepo.dart';
import 'package:meta/meta.dart';

part 'chefsorders_event.dart';
part 'chefsorders_state.dart';

class ChefsordersBloc extends Bloc<ChefsordersEvent, ChefsordersState> {
  ChefsordersBloc() : super(ChefsordersInitial());

  ChefRepo chefRepo = ChefRepo();
  @override
  Stream<ChefsordersState> mapEventToState(
    ChefsordersEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is ChefsorderFetch) {
      yield ChefsorderLoading();
      List<MealOrder> mealOrders = await chefRepo.getMealOrders();
      yield ChefsorderDone(mealOrders);
    } else if (event is ChefsorderReject) {
      List<MealOrder> mealOrders = await chefRepo.rejectOrder(event.id);
      yield ChefsorderDone(mealOrders);
    } else if (event is ChefsorderAccept) {
      List<MealOrder> mealOrders = await chefRepo.acceptOrder(event.id);
      yield ChefsorderDone(mealOrders);
    } else if (event is ChefsorderToAvailable) {
      yield ChefsorderLoading();
      await chefRepo.changeState();
      List<MealOrder> mealOrders = await chefRepo.getMealOrders();
      yield ChefsorderDone(mealOrders);
    } else if (event is ChefsorderToUnAvailable) {
      yield ChefsorderLoading();
      await chefRepo.changeState();
      // List<MealOrder> mealOrders = await chefRepo.getMealOrders();
      yield ChefordeUnavalibale();
    }
  }
}

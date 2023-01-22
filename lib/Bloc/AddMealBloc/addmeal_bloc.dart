import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:co_chef_mobile/Repositories/ChefRepo.dart';
import 'package:meta/meta.dart';

part 'addmeal_event.dart';
part 'addmeal_state.dart';

class AddmealBloc extends Bloc<AddmealEvent, AddmealState> {
  AddmealBloc() : super(AddmealInitial());

  ChefRepo chefRepo = ChefRepo();
  @override
  Stream<AddmealState> mapEventToState(
    AddmealEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is Addmeal) {
      if (event.name == '')
        yield AddmealFailed('الرجاء ادخال اسم');
      else if (event.preparationTime == '0')
        yield AddmealFailed('الرجاء ادخال مدة التحضير');
      else if (event.sharesNumber == '0')
        yield AddmealFailed('الرجاء ادخال عدد الحصص');
      else if (event.howToPrepare == '')
        yield AddmealFailed('الرجاء ادخال المكونات');
      else if (event.mealCategoryId == '-1')
        yield AddmealFailed('الرجاء اختيار صنف الطبق');
      else if (event.price == '')
        yield AddmealFailed('الرجاء ادخال السعر');
      else {
        yield AddmealLoading();
        bool result = await chefRepo.addMeal(event.name, event.price, event.sharesNumber, event.preparationTime,
            event.howToPrepare, event.mealCategoryId, event.image);
        if (result)
          yield AddmealDone();
        else
          yield AddmealFailed('لم يتم انشاء الوصفة');
      }
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:co_chef_mobile/Models/RecipeCategories.dart';
import 'package:co_chef_mobile/Repositories/RecipecategoriesRepo.dart';
import 'package:meta/meta.dart';

part 'recipecategories_event.dart';
part 'recipecategories_state.dart';

class RecipecategoriesBloc extends Bloc<RecipecategoriesEvent, RecipecategoriesState> {
  RecipecategoriesBloc() : super(RecipecategoriesInitial());

  RecipecategoriesRepo recipecategoriesRepo = RecipecategoriesRepo();
  @override
  Stream<RecipecategoriesState> mapEventToState(
    RecipecategoriesEvent event,
  ) async* {
    if (event is RecipecategoriesFetch) {
      yield RecipecategoriesLoading();
      List<RecipeCategory> categories = await recipecategoriesRepo.getCategories();
      if (categories.isNotEmpty)
        yield RecipecategoriesDone(categories);
      else
        yield RecipecategoriesFailed();
    }
  }
}

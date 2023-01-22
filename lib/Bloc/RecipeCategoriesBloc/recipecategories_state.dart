part of 'recipecategories_bloc.dart';

@immutable
abstract class RecipecategoriesState {}

class RecipecategoriesInitial extends RecipecategoriesState {}

class RecipecategoriesLoading extends RecipecategoriesState {}

class RecipecategoriesDone extends RecipecategoriesState {
  final List<RecipeCategory> categories;

  RecipecategoriesDone(this.categories);
}

class RecipecategoriesFailed extends RecipecategoriesState {}

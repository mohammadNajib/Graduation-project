part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchDone extends SearchState {
  final List<Meal>? data;
  final List<Recipe>? recipes;
  final List<OtherProfile>? users;
  SearchDone({this.data, this.recipes, this.users});
}

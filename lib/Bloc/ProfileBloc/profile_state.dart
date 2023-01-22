part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileDataLoading extends ProfileState {}

class ProfileDataDone extends ProfileState {
  final OtherProfile otherProfile;
  final List<Recipe>? recipes;
  ProfileDataDone(this.otherProfile, {this.recipes});
}

class ProfileFollowLoading extends ProfileState {}

class ProfileFollowDone extends ProfileState {}

part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileGetData extends ProfileEvent {
  final int userId;

  ProfileGetData(this.userId);
}

class ProfileFollowUser extends ProfileEvent {
  final int userId;

  ProfileFollowUser(this.userId);
}

class ProfileUnFollowUser extends ProfileEvent {
  final int userId;

  ProfileUnFollowUser(this.userId);
}

part of 'followlists_bloc.dart';

@immutable
abstract class FollowlistsEvent {}

class FollowListsGetFollowers extends FollowlistsEvent {}

class FollowListsGetFollowing extends FollowlistsEvent {}

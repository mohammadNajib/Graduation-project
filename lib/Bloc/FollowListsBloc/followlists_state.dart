part of 'followlists_bloc.dart';

@immutable
abstract class FollowlistsState {}

class FollowlistsInitial extends FollowlistsState {}

class FollowListsLoading extends FollowlistsState {}

class FollowListFetchDone extends FollowlistsState {
  final List<OtherProfile> profiles;

  FollowListFetchDone(this.profiles);
}

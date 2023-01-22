import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:co_chef_mobile/Models/otherUsers.dart';
import 'package:co_chef_mobile/Repositories/followListsRepo.dart';
import 'package:meta/meta.dart';

part 'followlists_event.dart';
part 'followlists_state.dart';

class FollowlistsBloc extends Bloc<FollowlistsEvent, FollowlistsState> {
  FollowlistsBloc(this.followListsRepo) : super(FollowlistsInitial());
  final FollowListsRepo followListsRepo;

  @override
  Stream<FollowlistsState> mapEventToState(
    FollowlistsEvent event,
  ) async* {
    if (event is FollowListsGetFollowers) {
      yield FollowListsLoading();
      List<OtherProfile> profiles = await followListsRepo.getFollowers();
      yield FollowListFetchDone(profiles);
    } else if (event is FollowListsGetFollowing) {
      yield FollowListsLoading();
      List<OtherProfile> profiles = await followListsRepo.getFollowing();
      yield FollowListFetchDone(profiles);
    }
  }
}

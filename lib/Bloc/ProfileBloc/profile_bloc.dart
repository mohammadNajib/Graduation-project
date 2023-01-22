import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:co_chef_mobile/Models/Recipe.dart';
import 'package:co_chef_mobile/Models/otherUsers.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';
import 'package:co_chef_mobile/Repositories/otherUsersRepo.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.otherUsersRepo}) : super(ProfileInitial());

  UserRepo userrepo = UserRepo();

  final OtherUsersRepo otherUsersRepo;
  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileGetData) {
      yield ProfileDataLoading();
      OtherProfile otherprofile = await otherUsersRepo.getProfileData(event.userId);
      List<Recipe> recipes = await otherUsersRepo.getUserRecipes(event.userId);
      yield ProfileDataDone(otherprofile, recipes: recipes);
    } else if (event is ProfileFollowUser) {
      await otherUsersRepo.followUser(event.userId);
      yield ProfileDataDone(otherUsersRepo.otherProfile);
    } else if (event is ProfileUnFollowUser) {
      await otherUsersRepo.unFollowUser(event.userId);
      yield ProfileDataDone(otherUsersRepo.otherProfile);
    }
  }
}

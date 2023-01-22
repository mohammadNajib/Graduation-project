import 'package:co_chef_mobile/Bloc/FollowListsBloc/followlists_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Repositories/followListsRepo.dart';
import 'package:co_chef_mobile/Widgets/UserCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

class UsersList extends StatefulWidget {
  static String route = '/UsersList';

  final bool? followers;

  const UsersList({Key? key, this.followers}) : super(key: key);
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    FollowListsRepo followListsRepo = FollowListsRepo();
    return BlocProvider(
      create: (context) => FollowlistsBloc(followListsRepo)
        ..add(widget.followers! ? FollowListsGetFollowers() : FollowListsGetFollowing()),
      child: BlocBuilder<FollowlistsBloc, FollowlistsState>(
        builder: (context, state) {
          if (state is FollowListsLoading)
            return Scaffold(
              body: Center(
                child: ScalingText(
                  'Co-Chef',
                  style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
                ),
              ),
            );
          if (state is FollowListFetchDone)
            return Scaffold(
              backgroundColor: color4,
              body: Container(
                height: MediaQuery.of(context).size.height * 0.84,
                child: ListView.builder(
                  itemCount: state.profiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return UserCard(
                      profile: state.profiles[index],
                    );
                  },
                ),
              ),
            );
          else
            return Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
        },
      ),
    );
  }

  @override
  void dispose() {
    // BlocProvider.of<FollowlistsBloc>(context).close();
    super.dispose();
  }
}

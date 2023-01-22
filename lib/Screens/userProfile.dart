import 'package:co_chef_mobile/Bloc/ProfileBloc/profile_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:co_chef_mobile/Models/Recipe.dart';
import 'package:co_chef_mobile/Repositories/otherUsersRepo.dart';
import 'package:co_chef_mobile/Widgets/RecipeCard.dart';
import 'package:co_chef_mobile/Widgets/UserIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_indicators/progress_indicators.dart';

// import 'ProfileButton.dart';

class UserProfile extends StatefulWidget {
  final int? id;
  UserProfile({Key? key, this.id}) : super(key: key);

  static String route = "/UserProfile";

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<Recipe> recipes = [];
  @override
  Widget build(BuildContext context) {
    // AuthenticationBloc authenticationBloc =
    //     BlocProvider.of<AuthenticationBloc>(context);
    return BlocProvider(
      create: (context) => ProfileBloc(otherUsersRepo: OtherUsersRepo())..add(ProfileGetData(widget.id!)),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDataLoading)
            return Scaffold(
              body: Center(
                child: ScalingText(
                  'Co-Chef',
                  style: TextStyle(color: AppColors.color2, fontSize: 35.0, fontFamily: 'Pacifico'),
                ),
              ),
            );
          if (state is ProfileDataDone) {
            recipes = state.recipes ?? recipes;
            return Scaffold(
              // appBar: AppBar(),
              body: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.5,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.7),
                              blurRadius: 2,
                              spreadRadius: 3,
                            )
                          ],
                          color: AppColors.color2,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          )),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo[500],
                                      borderRadius: BorderRadius.circular(52.5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.color3,
                                          spreadRadius: 2,
                                        )
                                      ]),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage('images/Default-Profile-Picture.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                              child: Text(state.otherProfile.name!,
                                  style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold))),
                          state.otherProfile.isChef!
                              ? Center(
                                  child: Text(
                                    state.otherProfile.mobile!,
                                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Container(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      state.otherProfile.isFollowing! ? AppColors.color4 : AppColors.color3),
                              child: Text(
                                state.otherProfile.isFollowing! ? 'اتابعه' : 'متابعة',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                              ),
                              onPressed: () {
                                if (state.otherProfile.isFollowing!)
                                  BlocProvider.of<ProfileBloc>(context).add(ProfileUnFollowUser(widget.id!));
                                else
                                  BlocProvider.of<ProfileBloc>(context).add(ProfileFollowUser(widget.id!));
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              ProfileIcon(
                                data: state.otherProfile.followersCount.toString(),
                                text: 'المتابعين',
                                // route: '/UsersList',
                                // onTap: () =>
                                //     Navigator.pushNamed(context, '/UsersList'),
                              ),
                              ProfileIcon(
                                data: state.otherProfile.followingsCount.toString(),
                                text: 'يتابع',
                                // route: '/UsersList',
                              ),
                              ProfileIcon(
                                data: state.otherProfile.recipesCount.toString(),
                                text: 'وصفاته',
                                // route: '/page1',
                                // onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: ListView.builder(
                        shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        itemCount: recipes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              width: MediaQuery.of(context).size.width * 0.334,
                              child: RecipeCard(
                                recipe: recipes[index],
                              ));
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Text('data');
        },
      ),
    );
  }
}

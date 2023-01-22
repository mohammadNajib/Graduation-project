import 'package:co_chef_mobile/Bloc/AuthenticationBloc/authentication_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:co_chef_mobile/Screens/UsersList.dart';
import 'package:co_chef_mobile/Widgets/profileButtons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'ProfileButton.dart';
import '../../Widgets/UserIcon.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  static String route = "/Profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
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
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: MediaQuery.of(context).size.height * 0.09,
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
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Center(
                    child: Text(
                      authenticationBloc.userRepo.userName!,
                      style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Text(
                      authenticationBloc.userRepo.mobileNumber!,
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ProfileIcon(
                        data: authenticationBloc.userRepo.followersCount.toString(),
                        text: 'أتابع',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UsersList(
                                      followers: true,
                                    ))),
                      ),
                      ProfileIcon(
                        data: authenticationBloc.userRepo.followingCount.toString(),
                        text: 'يتابعني',
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UsersList(
                                      followers: false,
                                    ))),
                      ),
                      ProfileIcon(
                        data: authenticationBloc.userRepo.recipeCount.toString(),
                        text: 'وصفاتي',
                        // route: '/page1',
                        // onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ProfileButtons()
          ],
        ),
      ),
    );
  }
}

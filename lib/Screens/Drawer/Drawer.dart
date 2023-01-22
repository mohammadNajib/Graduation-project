import 'package:co_chef_mobile/Bloc/AuthenticationBloc/authentication_bloc.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';
import 'package:co_chef_mobile/Screens/ChefOrdersScreen.dart';
import 'package:co_chef_mobile/Screens/Drawer/DrawerWidget.dart';
import 'package:co_chef_mobile/Screens/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    UserRepo userRepo = UserRepo();
    return Drawer(
      child: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              width: double.infinity,
              color: AppColors.color2,
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('images/cochef2.png'),
                  Text(authenticationBloc.userRepo.userName!, style: TextStyle(color: Colors.white, fontSize: 20.0))
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: double.infinity,
              child: Column(
                children: [
                  DrawerWidget(icon: Icons.person, text: 'صفحة الشخصية'),
                  DrawerWidget(icon: Icons.contact_support_outlined, text: 'تواصل معنا'),
                  DrawerWidget(icon: Icons.android, text: 'حول التطبيق'),
                  (userRepo.chefId != null)
                      ? DrawerWidget(
                          icon: Icons.restaurant,
                          text: 'طباخ',
                          function: () {
                            Navigator.pushNamed(context, ChefOrderScreen.route);
                          },
                        )
                      : Container(),
                  DrawerWidget(
                    icon: Icons.logout,
                    text: 'تسجيل خروج',
                    function: () {
                      authenticationBloc.add(LogOut());
                      Navigator.of(context).pushNamedAndRemoveUntil(WelcomePage.route, (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

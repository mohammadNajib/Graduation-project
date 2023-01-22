import 'package:co_chef_mobile/Bloc/AuthenticationBloc/authentication_bloc.dart';
import 'package:co_chef_mobile/Screens/PasswordPage.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'SignupPage.dart';

class WelcomePage extends StatelessWidget {
  static String route = '/WelcomePage';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('images/background.png'), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50.0, left: 50.0, top: 120.0),
                    child: Image.asset(
                      'images/cochef3.png',
                    ),
                  )),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: WelcomingWidgets(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

const TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 20.0);
TextEditingController controller = TextEditingController();
final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

class WelcomingWidgets extends StatelessWidget {
  const WelcomingWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: authenticationBloc,
        buildWhen: (previousState, state) {
          if (state is LoginFalied && previousState is! LoginFalied)
            Fluttertoast.showToast(
                msg: state.errorMeassage,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          return true;
        },
        builder: (context, state) {
          print(state);
          if (state is LogInLoading) {
            print('loading log in');
            return Center(
                child: CircularProgressIndicator(
              color: AppColors.color4,
            ));
          } else if (state is LogInSuccess) {
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.pushNamed(context, PasswordPage.route);
            });
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: AppColors.color2,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: TextField(
                    controller: controller,
                    style: textStyle,
                    cursorColor: Colors.white,
                    autofocus: true,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your Mobile Number',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 1.0),
                      prefix: Text(
                        ' +963  ',
                        style: textStyle,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 32),
                decoration: BoxDecoration(
                  color: AppColors.color2,
                  border: Border.all(color: AppColors.color2),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextButton(
                  child: Text('Continue', style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () {
                    authenticationBloc.add(LogIn(number: controller.text));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 30),
                decoration: BoxDecoration(
                  // color: Colors.green,
                  border: Border.all(color: AppColors.color2),
                  // shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextButton(
                  child: Text('Sign Up', style: TextStyle(fontSize: 20, color: AppColors.color2)),
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpPage.route);
                  },
                ),
              ),
            ],
          );
        });
  }
}

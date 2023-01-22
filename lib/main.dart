import 'package:co_chef_mobile/Bloc/AuthenticationBloc/authentication_bloc.dart';
import 'package:co_chef_mobile/Bloc/Cartbloc/cart_bloc.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';
import 'package:co_chef_mobile/Screens/MainScreens/MainPageTest.dart';
import 'package:co_chef_mobile/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Routes.dart';
import 'Screens/WelcomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepo userRepo = UserRepo();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(userRepo)..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => CartBloc()..add(CartLoadData()),
          ),
        ],
        child: MaterialApp(
            title: 'Co-Chef',
            routes: routes,
            debugShowCheckedModeBanner: false,
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                print('decision page state $state');
                if (state is AuthenticationInitial)
                  return SplashScreen();
                else if (state is AuthenticationAuthenticated)
                  return MainSkeleton();
                else if (state is AuthenticationNotAuthenticated)
                  return WelcomePage();
                else
                  return WelcomePage();
              },
            )));
  }
}

// import 'package:co_chef_mobile/Bloc/AuthenticationBloc/authentication_bloc.dart';
// import 'package:co_chef_mobile/Routes.dart';
// import 'package:co_chef_mobile/Screens/Testing/MainPageTest.dart';
// import 'package:co_chef_mobile/Screens/WelcomePage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:co_chef_mobile/Screens/SplashScreen.dart';

// class DecisionPage extends StatefulWidget {
//   @override
//   _DecisionPageState createState() => _DecisionPageState();
// }

// class _DecisionPageState extends State<DecisionPage> {
//   @override
//   Widget build(BuildContext context) {
//     AuthenticationBloc authenticationBloc =
//         BlocProvider.of<AuthenticationBloc>(context);
//     return MaterialApp(
//         title: 'Co-Chef',
//         routes: routes,
//         home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//           bloc: authenticationBloc,
//           builder: (context, state) {
//             print('decision page state $state');
//             if (state is AuthenticationInitial)
//               return SplashScreen();
//             else if (state is AuthenticationAuthenticated)
//               return MainPageTest();
//             else if (state is AuthenticationNotAuthenticated)
//               return WelcomePage();
//             else
//               return WelcomePage();
//           },
//         ));
//   }
// }

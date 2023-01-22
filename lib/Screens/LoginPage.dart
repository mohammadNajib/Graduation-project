import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  static String route = '/LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

const TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 20.0);
TextEditingController controller = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/background.png'), fit: BoxFit.fill),
        ),
        child: Stack(fit: StackFit.expand, children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Padding(padding: const EdgeInsets.all(50.0), child: Image.asset('images/cochef.png'))),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

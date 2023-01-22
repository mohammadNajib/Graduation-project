import 'package:co_chef_mobile/Bloc/AuthenticationBloc/authentication_bloc.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart';
import 'package:co_chef_mobile/Screens/MainScreens/MainPageTest.dart';
import 'package:co_chef_mobile/Widgets/AppTextField.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:co_chef_mobile/Constants/AppColors.dart' as AppColors;

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  static String route = '/Signup';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

const TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 20.0);

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController mobileNumberController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  String birthDateHintText = 'تاريخ الميلاد';
  String genderHintText = 'الجنس';
  bool isDateSelected = false;
  late DateTime birthDate; // instance of DateTime  genderNumberController
  late String birthDateInString;
  String dropdownValue = 'tata';

  @override
  void initState() {
    super.initState();
    genderController.text = 'ذكر';
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previousState, state) {
        if (state is SignupFalied && previousState is! SignupFalied)
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
        if (state is SignupLoading)
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.color4,
              ),
            ),
          );
        else if (state is SignupSuccess)
          Future.delayed(Duration(milliseconds: 500), () {
            Navigator.of(context).pushNamedAndRemoveUntil(MainSkeleton.route, (Route<dynamic> route) => false);
          });
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/background.png'), fit: BoxFit.fill),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                  child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.2,
                    ),
                    AppTextField(
                      width: MediaQuery.of(context).size.width * 0.8,
                      controller: nameController,
                      hintText: 'الاسم',
                      textInputType: TextInputType.text,
                    ),
                    AppTextField(
                      width: MediaQuery.of(context).size.width * 0.8,
                      controller: mobileNumberController,
                      hintText: 'رقم الموبايل',
                      textInputType: TextInputType.number,
                    ),
                    GestureDetector(
                        child: Container(
                          child: Center(
                            child: Text(
                              birthDateHintText,
                              style: TextStyle(color: Colors.white, fontSize: 15.0),
                            ),
                          ),
                          margin: EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.13,
                          decoration: BoxDecoration(
                            color: color2,
                            border: Border.all(
                              color: color2,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        onTap: () async {
                          // print(' and you are here ya basha');
                          final datePick = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (datePick != null && datePick != birthDate) {
                            setState(() {
                              birthDate = datePick;
                              isDateSelected = true;
                              birthDateInString = "${birthDate.year}-${birthDate.month}-${birthDate.day}";
                              birthDateHintText = birthDateInString;
                            });
                          }
                        }),
                    PopupMenuButton<String>(
                      child: Container(
                        child: Center(
                          child: Text(
                            genderController.text,
                            style: TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ),
                        margin: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.13,
                        decoration: BoxDecoration(
                          color: color2,
                          border: Border.all(
                            color: color2,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      onSelected: (value) {
                        setState(() {
                          genderController.text = value;
                        });
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'ذكر',
                          child: Text('ذكر'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'أنثى',
                          child: Text('انثى'),
                        ),
                        // const PopupMenuItem<String>(
                        //   value: '',
                        //   child: Text('Being a self-starter'),
                        // ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32, bottom: 16),
                      decoration: BoxDecoration(
                          color: AppColors.color2,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      height: MediaQuery.of(context).size.width * 0.13,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextButton(
                        onPressed: () async {
                          authenticationBloc.add(SignUp(
                              username: nameController.text,
                              number: mobileNumberController.text,
                              gender: genderController.text,
                              birth: birthDateInString));
                        },
                        child: Text(
                          'Continue',
                          style: textStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
        );
      },
    );
  }
}

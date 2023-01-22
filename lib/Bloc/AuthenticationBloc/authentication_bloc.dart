import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:co_chef_mobile/Repositories/UserRepo.dart';
import 'package:meta/meta.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.userRepo) : super(AuthenticationInitial());

  final UserRepo userRepo;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield AuthenticationInitial();
      bool userExist = await userRepo.getdata();
      print('app started : $userExist');
      if (userExist)
        yield AuthenticationAuthenticated();
      else
        yield AuthenticationNotAuthenticated();
    } else if (event is LogOut) {
      print('logging out');
      await userRepo.deleteData();
      yield AuthenticationNotAuthenticated();
    } else if (event is LogIn) {
      yield LogInLoading();
      String loginstatus = await userRepo.login(event.number);
      if (loginstatus == 'User Authenticated')
        yield LogInSuccess();
      else
        yield LoginFalied(loginstatus);
    } else if (event is SignUp) {
      yield SignupLoading();
      if (event.username == '')
        yield SignupFalied('الرجاء ادخال اسم');
      else if (event.number == '')
        yield SignupFalied('الرجاء ادخال رقم موبايل');
      else {
        String res = await userRepo.signup(event.username, event.number, event.birth, event.gender);
        if (res == 'User Authenticated')
          yield SignupSuccess();
        else
          yield SignupFalied(res);
      }
    }
  }
}

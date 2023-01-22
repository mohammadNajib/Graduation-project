part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AppStarted extends AuthenticationEvent {}

class LogOut extends AuthenticationEvent {}

class LogIn extends AuthenticationEvent {
  final String number;

  LogIn({required this.number});
}

class SignUp extends AuthenticationEvent {
  final String username;
  final String number;
  final String birth;
  final String gender;

  SignUp({required this.username, required this.number, required this.birth, required this.gender});
}

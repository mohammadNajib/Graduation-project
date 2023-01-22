part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

class AuthenticationNotAuthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class LoggingIn extends AuthenticationState {}

class LogInLoading extends AuthenticationState {}

class LogInSuccess extends AuthenticationState {}

class LoginFalied extends AuthenticationState {
  final String errorMeassage;

  LoginFalied(this.errorMeassage);
}

class SignupLoading extends AuthenticationState {}

class SignupSuccess extends AuthenticationState {}

class SignupFalied extends AuthenticationState {
  final String errorMeassage;

  SignupFalied(this.errorMeassage);
}

part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupButtonClicked extends SignupEvent {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  SignupButtonClicked(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.password});
}

class ForgotPassEmailClicked extends SignupEvent {
  final String email;

  ForgotPassEmailClicked({required this.email});
}

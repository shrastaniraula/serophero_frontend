part of 'signup_bloc.dart';

abstract class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final SignupModel signuplist;

  SignupSuccess({required this.signuplist});
}

final class SignupFailure extends SignupState {
  final String error;

  SignupFailure({required this.error});
}

final class EmailPasswordSuccess extends SignupState {
  final SignupModel signuplist;

  EmailPasswordSuccess({required this.signuplist});
}

part of 'otp_pass_bloc.dart';

abstract class OtpPassState {}

final class OtpPassInitial extends OtpPassState {}

final class OtpPassLoading extends OtpPassState {}

final class OtpPassSuccess extends OtpPassState {
  OtpPassSuccess();
}

final class OtpPassFailure extends OtpPassState {
  final String error;

  OtpPassFailure({required this.error});
}

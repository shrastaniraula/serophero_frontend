part of 'otp_pass_bloc.dart';

abstract class OtpPassEvent {}

class OtpPassClicked extends OtpPassEvent {
  final String enteredOtp;
  final String otpKey;
  final String email;
  final String purpose;
  final String? newPassword;

  OtpPassClicked(
      {required this.newPassword,
      required this.enteredOtp,
      required this.otpKey,
      required this.email,
      required this.purpose});
}

// class ForgotPassEmailClicked extends OtpPassEvent {
//   final String email;

//   ForgotPassEmailClicked({required this.email});
// }

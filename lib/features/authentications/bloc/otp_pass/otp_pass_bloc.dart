import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/authentications/data/otp_pass/otp_pass_repo.dart';

part 'otp_pass_event.dart';
part 'otp_pass_state.dart';

class OtpPassBloc extends Bloc<OtpPassEvent, OtpPassState> {
  OtpPassBloc() : super(OtpPassInitial()) {
    on<OtpPassEvent>((event, emit) => signupBloc(event, emit));
  }

  void signupBloc(OtpPassEvent event, Emitter<OtpPassState> emit) async {
    if (event is OtpPassClicked) {
      emit(OtpPassLoading());
      try {
        await OtpPassRepo().otp(
            email: event.email,
            enteredOtp: event.enteredOtp,
            otpKey: event.otpKey,
            purpose: event.purpose,
            newPassword: event.newPassword);
        emit(OtpPassSuccess());
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(OtpPassFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else {
              emit(OtpPassFailure(error: error.response?.data["message"][0]));
            }
          } else {
            emit(OtpPassFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          print(error);
          emit(OtpPassFailure(
              error: "Your OTP was unverified, enter valid OTP"));
        }
      }
    }
  }
}

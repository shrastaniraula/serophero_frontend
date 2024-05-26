import 'package:serophero/features/authentications/data/signup/signup_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/authentications/data/signup/signup_repo.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) => signupBloc(event, emit));
  }

  void signupBloc(SignupEvent event, Emitter<SignupState> emit) async {
    if (event is SignupButtonClicked) {
      emit(SignupLoading());
      try {
        SignupModel signuplist = await SignupRepo().signup(
            firstname: event.firstname,
            lastname: event.lastname,
            email: event.email,
            password: event.password);
        emit(SignupSuccess(signuplist: signuplist));
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(SignupFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else {
              emit(SignupFailure(error: error.response?.data["message"][0]));
            }
          } else {
            emit(SignupFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          print(error);
          emit(SignupFailure(error: "Please enter valid email."));
        }
      }
    } else if (event is ForgotPassEmailClicked) {
      emit(SignupLoading());
      try {
        SignupModel signuplist = await SignupRepo().forgotPass(
          email: event.email,
        );
        emit(EmailPasswordSuccess(signuplist: signuplist));
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(SignupFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else {
              emit(SignupFailure(error: error.response?.data["message"][0]));
            }
          } else {
            emit(SignupFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          print(error);
          emit(SignupFailure(error: "Please enter a valid email."));
        }
      }
    }
  }
}

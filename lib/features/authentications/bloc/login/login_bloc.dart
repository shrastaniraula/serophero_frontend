import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/authentications/data/login/login_model.dart';
import 'package:serophero/features/authentications/data/login/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        User user =
            await loginRepository.loginUser(event.email, event.password);

        yield LoginSuccess(user: user);
      } catch (error) {
        print("");

        print(error);
        print("");
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              yield LoginFailure(
                  error: 'Connection timed out. Please try again later.');
            } else if (statusCode == 401) {
              yield LoginFailure(
                  error:
                      'Please make sure the username and password is correct.');
            } else {
              yield LoginFailure(error: error.response?.data["message"][0]);
            }
          } else {
            yield LoginFailure(
                error: "Something went wrong, please try again later.");
          }
        } else {
          yield LoginFailure(
              error: "Something went wrong, please try again laterrrr.");
        }
      }
    } else if (event is LogoutButtonPressed) {
      await loginRepository.logoutUser();
      yield LoginInitial();
    }
  }
}

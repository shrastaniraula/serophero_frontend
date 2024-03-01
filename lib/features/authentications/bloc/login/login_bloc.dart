// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
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
        yield LoginFailure(error: 'Error: $error');
      }
    } else if (event is LogoutButtonPressed) {
      await loginRepository.logoutUser();
      yield LoginInitial();
    }
  }
}

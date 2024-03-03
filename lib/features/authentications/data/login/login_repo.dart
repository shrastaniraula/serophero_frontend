import 'package:dio/dio.dart';
import 'package:serophero/features/authentications/data/login/login_model.dart';
import 'package:serophero/utils/shared_preferences.dart';
import 'package:serophero/constants/app_urls.dart';

class LoginRepository {
  final Dio dio = Dio();

  Future<User> loginUser(String email, String password) async {
    Response response = await dio.post(
      AppUrls.login,
      data: {
        'email': email,
        'password': password,
      },
    );
    User user = User.fromJson(response.data);
    await SharedUtils.saveToken(user.accessToken);
    return user;
  }

  Future<void> logoutUser() async {
    // Implement logout logic if needed
    // For example, clear the saved token from shared preferences
    await SharedUtils.clearToken();
  }
}

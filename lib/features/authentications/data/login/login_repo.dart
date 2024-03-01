import 'package:dio/dio.dart';
import 'package:serophero/features/authentications/data/login/login_model.dart';
// import 'package:user_mobile_app/.env.dart';
import 'package:serophero/utils/shared_preferences.dart';
import 'package:serophero/constants/app_urls.dart';

class LoginRepository {
  final Dio dio = Dio();

  Future<User> loginUser(String email, String password) async {
    try {
      // Make login request to your API
      Response response = await dio.post(
        AppUrls.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        User user = User.fromJson(response.data);
        await SharedUtils.saveToken(user.accessToken);

        return user; // Login successful
      } else {
        print('Login failed: ${response.statusCode}');
        throw Exception('Login failed');
      }
    } catch (error) {
      // Handle network errors or other exceptions
      print('Login error: $error');
      throw Exception('Login error');
    }
  }

  Future<void> logoutUser() async {
    // Implement logout logic if needed
    // For example, clear the saved token from shared preferences
    await SharedUtils.clearToken();
  }
}

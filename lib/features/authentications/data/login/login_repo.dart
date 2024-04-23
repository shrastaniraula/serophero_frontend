import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:serophero/features/authentications/data/login/login_model.dart';
import 'package:serophero/notification_services.dart';
import 'package:serophero/utils/notification_token.dart';
import 'package:serophero/utils/shared_preferences.dart';
import 'package:serophero/constants/app_urls.dart';

class LoginRepository {
  final Dio dio = Dio();

  Future<User> loginUser(String email, String password) async {
    NotificationServices notificationservice = NotificationServices();
    var phone_key = await notificationservice.getDeviceToken();
    AndroidDeviceInfo device = await DeviceInformation.androidInfo();
    String device_name = device.brand;

    Response response = await dio.post(
      AppUrls.login,
      data: {
        'phone_key': phone_key,
        'device_name': device_name,
        'email': email,
        'password': password,
      },
    );
    User user = User.fromJson(response.data);
    await SharedUtils.saveToken(user.accessToken);
    return user;
  }

  Future<void> logoutUser() async {
    await SharedUtils.clearToken();
    NotificationServices notificationservice = NotificationServices();
    var phone_key = await notificationservice.getDeviceToken();

    try {
      await dio.post(
        AppUrls.logout,
        data: {
          'phone_key': phone_key,
        },
      );
    } catch (error) {
      throw Exception(error);
    }
  }
}

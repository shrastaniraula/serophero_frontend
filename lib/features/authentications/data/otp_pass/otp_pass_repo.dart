import 'package:dio/dio.dart';
import 'package:serophero/constants/app_urls.dart';

class OtpPassRepo {
  final Dio dio = Dio();

  Future<void> otp({
    required String enteredOtp,
    required String otpKey,
    required String email,
    required String purpose,
    String? newPassword,
  }) async {
    try {
      print(newPassword);
      print(purpose);
      if (newPassword != "") {
        final response = await dio.post(AppUrls.otp, data: {
          'entered_otp': enteredOtp,
          'email': email,
          'otp_key': otpKey,
          'purpose': purpose,
          'new_password': newPassword
        });
      } else {
        final response = await dio.post(AppUrls.otp, data: {
          'entered_otp': enteredOtp,
          'email': email,
          'otp_key': otpKey,
          'purpose': purpose,
          // 'new_password': newPassword
        });
      }

      // print(response.data);
    } catch (error) {
      print(error);
      throw Exception('Failed to load data');
    }
  }
}

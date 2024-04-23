import 'package:dio/dio.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/authentications/data/signup/signup_model.dart';

class SignupRepo {
  final Dio dio = Dio();

  Future<SignupModel> signup(
      {required String firstname,
      required String lastname,
      required String email,
      required String password}) async {
    // final token = await SharedUtils.getToken();
    try {
      final response = await dio.post(AppUrls.register,
          // options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {
            'email': email,
            'first_name': firstname,
            'last_name': lastname,
            'password': password
          });
      print(response.data);
      SignupModel signuplist =
          SignupModel.fromMap(response.data as Map<String, dynamic>);
      return signuplist;
    } catch (error) {
      print(error);
      throw Exception('Failed to load data');
    }
  }

  Future<SignupModel> forgotPass({required String email}) async {
    // final token = await SharedUtils.getToken();
    try {
      final response = await dio.post(AppUrls.resetPass,
          // options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {
            'email': email,
          });
      print(response.data);
      SignupModel signuplist =
          SignupModel.fromMap(response.data as Map<String, dynamic>);
      return signuplist;
    } catch (error) {
      print(error);
      throw Exception('Failed to load data');
    }
  }
}

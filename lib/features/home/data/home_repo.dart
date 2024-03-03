import 'package:dio/dio.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/utils/shared_preferences.dart';

class HomeRepo {
  final Dio dio = Dio();

  Future<Response> getUsername() async {
    final token = await SharedUtils.getToken();
    print(token);
    Response response = await dio.get(
      AppUrls.home,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    // print(response);
    return response;
  }
}

import 'package:dio/dio.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/utils/shared_preferences.dart';

class ReportRepo {
  final Dio dio = Dio();

  Future<void> report({
    required String reason,
    required String type,
    required int id,
  }) async {
    final token = await SharedUtils.getToken();

    try {
      final response = await dio.post(AppUrls.report,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {'reason': reason, 'type': type, 'id': id});
      print(response.data);
    } catch (error) {
      print(error);
    }
  }
}

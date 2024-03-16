import 'package:dio/dio.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/business/data/directories_model.dart';
import 'package:serophero/utils/shared_preferences.dart';

class BusinessRepo {
  final Dio dio = Dio();

  Future<List<DirectoriesModel>> getDirectories() async {
    final token = await SharedUtils.getToken();

    final response = await dio.get(
      AppUrls.directories,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    print(response);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;

      List<DirectoriesModel> directories_data = [];
      for (int i = 0; i < data.length; i++) {
        DirectoriesModel item =
            DirectoriesModel.fromMap(data[i] as Map<String, dynamic>);
        directories_data.add(item);
      }

      return directories_data;
    } else {
      print("error");
      throw Exception('Failed to load chat list');
    }
  }
}

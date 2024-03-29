import 'dart:io';

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

  Future<void> registerBusiness({
    required File? citizenFront,
    required File? citizenBack,
    required File? doc1,
    required File? doc2,
    required File? doc3,
    required String name,
    required String description,
  }) async {
    final token = await SharedUtils.getToken();
    try {
      FormData formData = FormData.fromMap({
        'citiz_front_image': await MultipartFile.fromFile(citizenFront!.path),
        'citiz_back_image': await MultipartFile.fromFile(citizenBack!.path),
        'optional_docs1_image': await MultipartFile.fromFile(doc1!.path),
        'optional_docs2_image': await MultipartFile.fromFile(doc2!.path),
        'optional_docs3_image': await MultipartFile.fromFile(doc3!.path),
        'name': name,
        'description': description,
      });
      final response = await dio.post(AppUrls.directoriesRegister,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: formData);
      print(response.data);
    } catch (error) {
      print(error);
    }
  }
}

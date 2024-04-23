import 'dart:io';
import 'package:dio/dio.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/news/data/news/news_model.dart';
import 'package:serophero/utils/shared_preferences.dart';

class NewsListRepo {
  final Dio dio = Dio();

  Future<void> addNews(
      {required String title,
      required String description,
      required File? image}) async {
    final token = await SharedUtils.getToken();

    print("repo");

    try {
      FormData formData = FormData.fromMap({
        'news_heading': title,
        'news_description': description,
        'news_image': await MultipartFile.fromFile(image!.path),
      });
      final response = await dio.post(AppUrls.newsAdd,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: formData);
      print(response.data);
    } catch (error) {
      print(error);
    }
  }

  Future<List<NewsListModel>> getNewsList() async {
    final token = await SharedUtils.getToken();

    final response = await dio.get(
      AppUrls.newsList,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;

      List<NewsListModel> newslist_data = [];
      for (int i = 0; i < data.length; i++) {
        // print("object");
        // print(data[i]);
        NewsListModel item =
            NewsListModel.fromMap(data[i] as Map<String, dynamic>);
        newslist_data.add(item);
      }
      print(response.data);

      return newslist_data;
    } else {
      print("error");
      throw Exception('Failed to load chat list');
    }
  }
}

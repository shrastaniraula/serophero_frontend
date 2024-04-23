import 'package:dio/dio.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/news/data/news/news_model.dart';
import 'package:serophero/utils/shared_preferences.dart';

class PersonalNewsListRepo {
  final Dio dio = Dio();

  Future<void> deleteNews({required String id}) async {
    final token = await SharedUtils.getToken();

    print("repo");

    try {
      final response = await dio.post(AppUrls.personalNews,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {"news_id": id});
      print(response.data);
    } catch (error) {
      print(error);
    }
  }

  Future<List<NewsListModel>> getPersonalNewsList() async {
    final token = await SharedUtils.getToken();

    final response = await dio.get(
      AppUrls.personalNews,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;

      List<NewsListModel> newslist_data = [];
      for (int i = 0; i < data.length; i++) {
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

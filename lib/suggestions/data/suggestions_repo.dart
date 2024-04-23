import 'package:dio/dio.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/suggestions/data/suggestions_model.dart';
import 'package:serophero/utils/shared_preferences.dart';

class SuggestionsRepo {
  final Dio dio = Dio();

  Future<List<SuggestionModel>> getSuggestions() async {
    final token = await SharedUtils.getToken();

    final response = await dio.get(
      AppUrls.suggestions,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;

      List<SuggestionModel> suggestions_data = [];
      for (int i = 0; i < data.length; i++) {
        SuggestionModel item =
            SuggestionModel.fromMap(data[i] as Map<String, dynamic>);
        suggestions_data.add(item);
      }
      print(suggestions_data);

      return suggestions_data;
    } else {
      print("error");
      throw Exception('Failed to load chat list');
    }
  }

  Future<void> addSuggestion({required String description}) async {
    final token = await SharedUtils.getToken();

    // try {
    FormData formData = FormData.fromMap({
      'description': description,
    });
    final response = await dio.post(AppUrls.suggestions,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: formData);
    print(response.data);
    // } catch (error) {
    //   print(error);
    // }
  }
}

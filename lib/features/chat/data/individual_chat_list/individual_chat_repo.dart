import 'package:dio/dio.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/chat/data/individual_chat_list/individual_chat_model.dart';
import 'package:serophero/utils/shared_preferences.dart';

class IndividualChatRepo {
  final Dio dio = Dio();

  Future<List<MessageModel>> getChatList(String userId) async {
    final token = await SharedUtils.getToken();

    final response = await dio.post(AppUrls.individualChat,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {'user_id': userId});
    print(response.data);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;

      List<MessageModel> chatlistData = [];
      for (int i = 0; i < data.length; i++) {
        // print("chat object");
        // print(data[i]);
        MessageModel item =
            MessageModel.fromMap(data[i] as Map<String, dynamic>);
        chatlistData.add(item);
      }

      return chatlistData;
    } else {
      print("error");
      throw Exception('Failed to load chat list');
    }
  }
}

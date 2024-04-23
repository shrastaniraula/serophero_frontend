import 'package:dio/dio.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/utils/shared_preferences.dart';
import 'package:serophero/features/notifications/data/notification_model.dart';

class NotificationRepo {
  final Dio dio = Dio();

  Future<List<NotificationModel>> getNotifications() async {
    final token = await SharedUtils.getToken();

    final response = await dio.get(
      AppUrls.notifications,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      // var decoded = jsonDecode(response.data);
      // print(decoded);
      // return [NotificationModel.fromMap(decoded)];

      // print(data);
      List<NotificationModel> notificationData = [];
      for (int i = 0; i < data.length; i++) {
        NotificationModel item =
            NotificationModel.fromMap(data[i] as Map<String, dynamic>);
        notificationData.add(item);
      }
      // print(notificationData);

      return notificationData;
    } else {
      print("error");
      throw Exception('Failed to load chat list');
    }
  }
}

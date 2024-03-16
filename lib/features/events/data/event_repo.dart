import 'package:dio/dio.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/events/data/event_model.dart';
import 'package:serophero/utils/shared_preferences.dart';

class EventListRepo {
  final Dio dio = Dio();

  Future<List<EventListModel>> getEventList() async {
    final token = await SharedUtils.getToken();

    final response = await dio.get(
      AppUrls.eventList,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;

      List<EventListModel> eventlist_data = [];
      for (int i = 0; i < data.length; i++) {
        EventListModel item =
            EventListModel.fromMap(data[i] as Map<String, dynamic>);
        eventlist_data.add(item);
      }
      print(eventlist_data);

      return eventlist_data;
    } else {
      print("error");
      throw Exception('Failed to load chat list');
    }
  }
}

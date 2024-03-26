import 'package:dio/dio.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/home/data/home_model.dart';
import 'package:serophero/utils/shared_preferences.dart';

class HomeRepo {
  final Dio dio = Dio();

  Future<HomeModel> getHomeData() async {
    final token = await SharedUtils.getToken();
    Response response = await dio.get(
      AppUrls.home,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    print(response.data);

    HomeModel homeModelData = HomeModel.fromMap(response.data);
    return homeModelData;
  }
}

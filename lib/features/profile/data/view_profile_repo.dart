import 'package:dio/dio.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/profile/data/view_profile_model.dart';
import 'package:serophero/utils/shared_preferences.dart';

class ViewProfileRepo {
  final Dio dio = Dio();

  Future<ViewProfileModel> getProfileData(int user) async {
    final token = await SharedUtils.getToken();

    final response = await dio.post(AppUrls.viewProfile,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {'user': user});
    print(response.data);

    ViewProfileModel userData = ViewProfileModel.fromMap(response.data[0]);
    return userData;
  }
}

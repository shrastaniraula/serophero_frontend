import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/profile/data/view_profile_model.dart';
import 'package:serophero/features/profile/data/view_profile_repo.dart';

part 'view_profile_event.dart';
part 'view_profile_state.dart';

class ViewProfileBloc extends Bloc<ViewProfileEvent, ViewProfileState> {
  ViewProfileBloc() : super(ViewProfileInitial()) {
    on<ViewProfileEvent>((event, emit) => getProfileView(event, emit));
  }

  void getProfileView(
      ViewProfileEvent event, Emitter<ViewProfileState> emit) async {
    if (event is ProfilePageOpened) {
      print("object");
      emit(ViewProfileLoading());
      try {
        print("trying");
        print(event.user);
        ViewProfileModel user_data =
            await ViewProfileRepo().getProfileData(event.user);
        print("bloc");
        emit(ViewProfileSuccess(user_data: user_data));
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(ViewProfileFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(ViewProfileFailure(
                  error: error.response?.data["message"][0]));
            }
          } else {
            print(error);
            emit(ViewProfileFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          print(error);

          emit(ViewProfileFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    }
  }
}

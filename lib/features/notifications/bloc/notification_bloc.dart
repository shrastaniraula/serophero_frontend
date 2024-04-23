import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/notifications/data/notification_model.dart';
import 'package:serophero/features/notifications/data/notification_repo.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) => getEventList(event, emit));
  }

  void getEventList(
      NotificationEvent event, Emitter<NotificationState> emit) async {
    if (event is NotificationPageOpened) {
      emit(NotificationLoading());
      try {
        List<NotificationModel> notificationlist =
            await NotificationRepo().getNotifications();
        emit(NotificationSuccess(notificationlist: notificationlist));
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(NotificationFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(NotificationFailure(
                  error: error.response?.data["message"][0]));
            }
          } else {
            print(error);
            print("Heeeeeeeeeeeee");
            emit(NotificationFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          print(error);
          print("bbbbbbbbbbbbbbbbbbbb");

          emit(NotificationFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    }
  }
}

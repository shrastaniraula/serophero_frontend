import 'package:serophero/features/news/data/news/news_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/news/data/personal_news/personal_news_repo.dart';

part 'personal_news_event.dart';
part 'personal_news_state.dart';

class PersonalNewsBloc extends Bloc<PersonalNewsEvent, PersonalNewsState> {
  PersonalNewsBloc() : super(PersonalNewsListInitial()) {
    on<PersonalNewsEvent>((event, emit) => getNewsList(event, emit));
  }

  void getNewsList(
      PersonalNewsEvent event, Emitter<PersonalNewsState> emit) async {
    if (event is PersonalNewsPageOpened) {
      emit(PersonalNewsListLoading());
      try {
        List<NewsListModel> newslist =
            await PersonalNewsListRepo().getPersonalNewsList();
        print("bloc");
        emit(PersonalNewsListSuccess(newslist: newslist));
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(PersonalNewsListFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(PersonalNewsListFailure(
                  error: error.response?.data["message"][0]));
            }
          } else {
            emit(PersonalNewsListFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          emit(PersonalNewsListFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    } else if (event is DeleteNews) {
      emit(PersonalNewsListLoading());
      try {
        print("INNN BLOOCCCC");
        await PersonalNewsListRepo().deleteNews(id: event.id);
        print("bloc");
        emit(NewsDeleteSuccess());
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(PersonalNewsListFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(PersonalNewsListFailure(
                  error: error.response?.data["message"][0]));
            }
          } else {
            emit(PersonalNewsListFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          emit(PersonalNewsListFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    }
  }
}

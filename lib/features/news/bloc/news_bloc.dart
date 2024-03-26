import 'dart:io';

import 'package:serophero/features/news/data/news_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/news/data/news_repo.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsListInitial()) {
    on<NewsEvent>((event, emit) => getNewsList(event, emit));
  }

  void getNewsList(NewsEvent event, Emitter<NewsState> emit) async {
    if (event is NewsPageOPened) {
      emit(NewsListLoading());
      try {
        List<NewsListModel> newslist = await NewsListRepo().getNewsList();
        print("bloc");
        emit(NewsListSuccess(newslist: newslist));
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(NewsListFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(NewsListFailure(error: error.response?.data["message"][0]));
            }
          } else {
            emit(NewsListFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          emit(NewsListFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    } else if (event is PostNews) {
      emit(NewsListLoading());
      try {
        print("INNN BLOOCCCC");
        await NewsListRepo().addNews(
          description: event.description,
          title: event.title,
          image: event.image,
        );
        print("bloc");
        emit(NewsPostSuccess());
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(NewsListFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(NewsListFailure(error: error.response?.data["message"][0]));
            }
          } else {
            emit(NewsListFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          emit(NewsListFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    }
  }
}

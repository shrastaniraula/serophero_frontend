part of 'news_bloc.dart';

abstract class NewsState {}

final class NewsListInitial extends NewsState {}

final class NewsListLoading extends NewsState {}

final class NewsListSuccess extends NewsState {
  final List<NewsListModel> newslist;

  NewsListSuccess({required this.newslist});
}

final class NewsListFailure extends NewsState {
  final String error;

  NewsListFailure({required this.error});
}

final class TokenExpired extends NewsState {}

final class NewsPostSuccess extends NewsState {
  NewsPostSuccess();
}

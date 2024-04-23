part of 'personal_news_bloc.dart';

abstract class PersonalNewsState {}

final class PersonalNewsListInitial extends PersonalNewsState {}

final class PersonalNewsListLoading extends PersonalNewsState {}

final class PersonalNewsListSuccess extends PersonalNewsState {
  final List<NewsListModel> newslist;

  PersonalNewsListSuccess({required this.newslist});
}

final class PersonalNewsListFailure extends PersonalNewsState {
  final String error;

  PersonalNewsListFailure({required this.error});
}

final class DeleteNewsFailure extends PersonalNewsState {
  final String error;

  DeleteNewsFailure({required this.error});
}

final class TokenExpired extends PersonalNewsState {}

final class NewsDeleteSuccess extends PersonalNewsState {
  NewsDeleteSuccess();
}

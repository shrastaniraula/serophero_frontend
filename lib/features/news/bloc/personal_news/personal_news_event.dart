part of 'personal_news_bloc.dart';

abstract class PersonalNewsEvent {}

class PersonalNewsPageOpened extends PersonalNewsEvent {
  PersonalNewsPageOpened();
}

class DeleteNews extends PersonalNewsEvent {
  final String id;

  DeleteNews({required this.id});
}

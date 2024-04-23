part of 'news_bloc.dart';

abstract class NewsEvent {}

class NewsPageOPened extends NewsEvent {
  NewsPageOPened();
}

class PostNews extends NewsEvent {
  final String title;
  final String description;
  final File? image;

  PostNews(
      {required this.title, required this.description, required this.image});
}

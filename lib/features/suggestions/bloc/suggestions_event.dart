part of 'suggestions_bloc.dart';

abstract class SuggestionsEvent {}

class SuggestionsPageOpened extends SuggestionsEvent {
  SuggestionsPageOpened();
}

class PostSuggestions extends SuggestionsEvent {
  final String description;

  PostSuggestions({
    required this.description,
  });
}

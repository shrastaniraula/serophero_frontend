part of 'suggestions_bloc.dart';

abstract class SuggestionsState {}

final class SuggestionsInitial extends SuggestionsState {}

final class SuggestionsLoading extends SuggestionsState {}

final class SuggestionsSuccess extends SuggestionsState {
  final List<SuggestionModel> suggestions;

  SuggestionsSuccess({required this.suggestions});
}

final class SuggestionsFailure extends SuggestionsState {
  final String error;

  SuggestionsFailure({required this.error});
}


final class SuggestionsProfane extends SuggestionsState {
  final String error;

  SuggestionsProfane({required this.error});
}

final class TokenExpired extends SuggestionsState {}

final class PostSuggestionSuccess extends SuggestionsState {
  PostSuggestionSuccess();
}

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/suggestions/data/suggestions_model.dart';
import 'package:serophero/features/suggestions/data/suggestions_repo.dart';

part 'suggestions_event.dart';
part 'suggestions_state.dart';

class SuggestionsBloc extends Bloc<SuggestionsEvent, SuggestionsState> {
  SuggestionsBloc() : super(SuggestionsInitial()) {
    on<SuggestionsEvent>((event, emit) => getEventList(event, emit));
  }

  void getEventList(
      SuggestionsEvent event, Emitter<SuggestionsState> emit) async {
    if (event is SuggestionsPageOpened) {
      emit(SuggestionsLoading());
      try {
        List<SuggestionModel> suggestions =
            await SuggestionsRepo().getSuggestions();
        emit(SuggestionsSuccess(suggestions: suggestions));
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(SuggestionsFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(SuggestionsFailure(
                  error: error.response?.data["message"][0]));
            }
          } else {
            print(error);
            emit(SuggestionsFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          print(error);

          emit(SuggestionsFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    } else if (event is PostSuggestions) {
      emit(SuggestionsLoading());
      try {
        await SuggestionsRepo().addSuggestion(
          description: event.description,
        );
        print("helooo bloc bloc");
        emit(PostSuggestionSuccess());
      } catch (error) {
        print("in catch");
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 406) {
              print("Heyy profanneee");
              emit(SuggestionsProfane(
                  error:
                      "Profane Detected!! Please use wise and respectful words."));
            } else if (statusCode == 522) {
              emit(SuggestionsFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(SuggestionsFailure(
                  error: error.response?.data["message"][0]));
            }
          } else {
            emit(SuggestionsFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          emit(SuggestionsFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    }
  }
}

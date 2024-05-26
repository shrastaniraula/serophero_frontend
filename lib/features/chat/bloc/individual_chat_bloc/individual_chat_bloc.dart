import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/chat/data/individual_chat_list/individual_chat_model.dart';
import 'package:serophero/features/chat/data/individual_chat_list/individual_chat_repo.dart';

part 'individual_chat_event.dart';
part 'individual_chat_state.dart';

class IndividualChatBloc
    extends Bloc<IndividualChatEvent, IndividualChatState> {
  IndividualChatBloc() : super(IndividualChatInitial()) {
    on<IndividualChatEvent>((event, emit) => individualgetChat(event, emit));
  }

  void individualgetChat(
      IndividualChatEvent event, Emitter<IndividualChatState> emit) async {
    if (event is IndividualChatOpened) {
      emit(IndividualChatLoading());
      try {
        print("chat bloc");
        List<MessageModel> chatlist =
            await IndividualChatRepo().getChatList(event.userId);
        emit(IndividualChatSuccess(chatlist: chatlist));
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(IndividualChatFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(IndividualChatFailure(
                  error: error.response?.data["message"][0]));
            }
          } else {
            emit(IndividualChatFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          print(error);
          emit(IndividualChatFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    }
  }
}

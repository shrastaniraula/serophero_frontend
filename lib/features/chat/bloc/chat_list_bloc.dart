import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/chat/data/chat_model.dart';
import 'package:serophero/features/chat/data/chat_repo.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc() : super(ChatListInitial()) {
    on<ChatListEvent>((event, emit) => getChatList(event, emit));
  }

  void getChatList(ChatListEvent event, Emitter<ChatListState> emit) async {
    if (event is ChatPageOPened) {
      emit(ChatListLoading());
      try {
        print("chat bloc");
        List<ChatList> chatlist = await ChatListRepo().getChatList();
        emit(ChatListSuccess(chatlist: chatlist));
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(ChatListFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(ChatListFailure(error: error.response?.data["message"][0]));
            }
          } else {
            emit(ChatListFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          print(error);
          emit(ChatListFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    }
  }
}

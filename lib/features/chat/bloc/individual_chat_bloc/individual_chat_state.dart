part of 'individual_chat_bloc.dart';

abstract class IndividualChatState {}

final class IndividualChatInitial extends IndividualChatState {}

final class IndividualChatLoading extends IndividualChatState {}

final class IndividualChatSuccess extends IndividualChatState {
  final List<MessageModel> chatlist;

  IndividualChatSuccess({required this.chatlist});
}

final class IndividualChatFailure extends IndividualChatState {
  final String error;

  IndividualChatFailure({required this.error});
}

final class TokenExpired extends IndividualChatState {}

part of 'individual_chat_bloc.dart';

abstract class IndividualChatEvent {}

class IndividualChatOpened extends IndividualChatEvent {
  final String userId;

  IndividualChatOpened({required this.userId});
}

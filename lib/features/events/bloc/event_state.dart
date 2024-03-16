part of 'event_bloc.dart';

abstract class EventState {}

final class EventListInitial extends EventState {}

final class EventListLoading extends EventState {}

final class EventListSuccess extends EventState {
  final List<EventListModel> eventlist;

  EventListSuccess({required this.eventlist});
}

final class EventListFailure extends EventState {
  final String error;

  EventListFailure({required this.error});
}

final class TokenExpired extends EventState {}

part of 'event_bloc.dart';

abstract class EventEvent {}

class EventPageOpened extends EventEvent {
  EventPageOpened();
}

class PostEvents extends EventEvent {
  final String eventHeading;
  final String eventDescription;
  final String eventLocation;
  final File? image;
  final DateTime eventTime;
  final List<dynamic> allowed;

  PostEvents(
      {required this.eventHeading,
      required this.eventLocation,
      required this.eventDescription,
      required this.image,
      required this.eventTime,
      required this.allowed});
}

part of 'notification_bloc.dart';

abstract class NotificationEvent {}

class NotificationPageOpened extends NotificationEvent {
  NotificationPageOpened();
}

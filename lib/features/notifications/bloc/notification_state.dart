part of 'notification_bloc.dart';

abstract class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationSuccess extends NotificationState {
  final List<NotificationModel> notificationlist;

  NotificationSuccess({required this.notificationlist});
}

final class NotificationFailure extends NotificationState {
  final String error;

  NotificationFailure({required this.error});
}

final class TokenExpired extends NotificationState {}



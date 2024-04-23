import 'dart:convert';

class NotificationModel {
  String? title;
  String? message;
  DateTime? notificationTime;
  NotificationModel({
    this.title,
    this.message,
    this.notificationTime,
  });

  NotificationModel copyWith({
    String? title,
    String? message,
    DateTime? notificationTime,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      message: message ?? this.message,
      notificationTime: notificationTime ?? this.notificationTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (title != null) {
      result.addAll({'title': title});
    }
    if (message != null) {
      result.addAll({'message': message});
    }
    if (notificationTime != null) {
      result.addAll(
          {'notificationTime': notificationTime!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'],
      message: map['message'],
      notificationTime: map['notification_time'] != null
          ? DateTime.parse(map['notification_time'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'NotificationModel(title: $title, message: $message, notificationTime: $notificationTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.title == title &&
        other.message == message &&
        other.notificationTime == notificationTime;
  }

  @override
  int get hashCode =>
      title.hashCode ^ message.hashCode ^ notificationTime.hashCode;
}

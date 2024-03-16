import 'dart:convert';

class EventListModel {
  final int id;
  final String eventTitle;
  final String eventDescription;
  final String eventImage;
  final String eventLocation;
  final DateTime postedDate;
  final DateTime eventDate;
  final int userId;
  final String postedBy;

  EventListModel({
    required this.id,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventImage,
    required this.eventLocation,
    required this.postedDate,
    required this.eventDate,
    required this.userId,
    required this.postedBy,
  });

  EventListModel copyWith({
    int? id,
    String? eventTitle,
    String? eventDescription,
    String? eventImage,
    String? eventLocation,
    DateTime? postedDate,
    DateTime? eventDate,
    int? userId,
    String? postedBy,
  }) {
    return EventListModel(
      id: id ?? this.id,
      eventTitle: eventTitle ?? this.eventTitle,
      eventDescription: eventDescription ?? this.eventDescription,
      eventImage: eventImage ?? this.eventImage,
      eventLocation: eventLocation ?? this.eventLocation,
      postedDate: postedDate ?? this.postedDate,
      eventDate: eventDate ?? this.eventDate,
      userId: userId ?? this.userId,
      postedBy: postedBy ?? this.postedBy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'event_id': id});
    result.addAll({'event_title': eventTitle});
    result.addAll({'event_description': eventDescription});
    result.addAll({'event_image': eventImage});
    result.addAll({'event_location': eventLocation});
    result.addAll({'posted_date': postedDate.millisecondsSinceEpoch});
    result.addAll({'event_date': eventDate.millisecondsSinceEpoch});
    result.addAll({'user_id': userId});
    result.addAll({'posted_by': postedBy});

    return result;
  }

  factory EventListModel.fromMap(Map<String, dynamic> map) {
    return EventListModel(
      id: map['event_id']?.toInt() ?? 0,
      eventTitle: map['event_title'] ?? '',
      eventDescription: map['event_description'] ?? '',
      eventImage: map['event_image'] ?? '',
      eventLocation: map['event_location'] ?? '',
      postedDate: DateTime.parse(map['posted_date']),
      eventDate: DateTime.parse(map['event_date']),
      userId: int.parse(map['user_id'] ?? '0'),
      postedBy: map['posted_by'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EventListModel.fromJson(String source) =>
      EventListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventListModel(id: $id, eventTitle: $eventTitle, eventDescription: $eventDescription, eventImage: $eventImage, eventLocation: $eventLocation, postedDate: $postedDate, eventDate: $eventDate, userId: $userId, postedBy: $postedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventListModel &&
        other.id == id &&
        other.eventTitle == eventTitle &&
        other.eventDescription == eventDescription &&
        other.eventImage == eventImage &&
        other.eventLocation == eventLocation &&
        other.postedDate == postedDate &&
        other.eventDate == eventDate &&
        other.userId == userId &&
        other.postedBy == postedBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        eventTitle.hashCode ^
        eventDescription.hashCode ^
        eventImage.hashCode ^
        eventLocation.hashCode ^
        postedDate.hashCode ^
        eventDate.hashCode ^
        userId.hashCode ^
        postedBy.hashCode;
  }
}

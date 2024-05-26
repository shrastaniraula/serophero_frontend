import 'dart:convert';

class SuggestionModel {
  final int by;
  final String description;
  final DateTime datetime;
  final String sender_name;
  final String sender_image;

  SuggestionModel({
    required this.by,
    required this.description,
    required this.datetime,
    required this.sender_name,
    required this.sender_image,
  });

  SuggestionModel copyWith({
    int? by,
    String? description,
    DateTime? datetime,
    String? sender_name,
    String? sender_image,
  }) {
    return SuggestionModel(
      by: by ?? this.by,
      description: description ?? this.description,
      datetime: datetime ?? this.datetime,
      sender_name: sender_name ?? this.sender_name,
      sender_image: sender_image ?? this.sender_image,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'by': by});
    result.addAll({'description': description});
    result.addAll({'datetime': datetime.millisecondsSinceEpoch});
    result.addAll({'sender_name': sender_name});
    result.addAll({'sender_image': sender_image});

    return result;
  }

  factory SuggestionModel.fromMap(Map<String, dynamic> map) {
    return SuggestionModel(
      by: map['by']?.toInt() ?? 0,
      description: map['description'] ?? '',
      datetime: DateTime.parse(map['datetime']),
      sender_name: map['sender_name'] ?? '',
      sender_image: map['sender_image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SuggestionModel.fromJson(String source) =>
      SuggestionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SuggestionModel(by: $by, description: $description, datetime: $datetime, sender_name: $sender_name, sender_image: $sender_image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SuggestionModel &&
        other.by == by &&
        other.description == description &&
        other.datetime == datetime &&
        other.sender_name == sender_name &&
        other.sender_image == sender_image;
  }

  @override
  int get hashCode {
    return by.hashCode ^
        description.hashCode ^
        datetime.hashCode ^
        sender_name.hashCode ^
        sender_image.hashCode;
  }
}

import 'dart:convert';

class MessageModel {
  final String message;
  final DateTime created;
  final bool sentByMe;

  MessageModel({
    required this.message,
    required this.created,
    required this.sentByMe,
  });

  MessageModel copyWith({
    String? message,
    DateTime? created,
    bool? sentByMe,
  }) {
    return MessageModel(
      message: message ?? this.message,
      created: created ?? this.created,
      sentByMe: sentByMe ?? this.sentByMe,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'message': message});
    result.addAll({'created': created.millisecondsSinceEpoch});
    result.addAll({'sent_by_me': sentByMe});

    return result;
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] ?? '',
      created: DateTime.parse(map['created']),
      sentByMe: map['sent_by_me'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'Message(message: $message, created: $created, sentByMe: $sentByMe)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.message == message &&
        other.created == created &&
        other.sentByMe == sentByMe;
  }

  @override
  int get hashCode => message.hashCode ^ created.hashCode ^ sentByMe.hashCode;
}

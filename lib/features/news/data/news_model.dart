import 'dart:convert';

class NewsListModel {
  final int id;
  final String newsTitle;
  final String newsDescription;
  final String newsImage;
  final DateTime newsDate;
  final String username;
  final int userId;

  NewsListModel({
    required this.id,
    required this.newsTitle,
    required this.newsDescription,
    required this.newsImage,
    required this.newsDate,
    required this.username,
    required this.userId,
  });

  NewsListModel copyWith({
    int? id,
    String? newsTitle,
    String? newsDescription,
    String? newsImage,
    DateTime? newsDate,
    String? username,
    int? userId,
  }) {
    return NewsListModel(
      id: id ?? this.id,
      newsTitle: newsTitle ?? this.newsTitle,
      newsDescription: newsDescription ?? this.newsDescription,
      newsImage: newsImage ?? this.newsImage,
      newsDate: newsDate ?? this.newsDate,
      username: username ?? this.username,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'news_title': newsTitle});
    result.addAll({'news_description': newsDescription});
    result.addAll({'news_image': newsImage});
    result.addAll({'news_date': newsDate.millisecondsSinceEpoch});
    result.addAll({'user_name': username});
    result.addAll({'user_id': userId});

    return result;
  }

  factory NewsListModel.fromMap(Map<String, dynamic> map) {
    return NewsListModel(
      id: map['id']?.toInt() ?? 0,
      newsTitle: map['news_title'] ?? '',
      newsDescription: map['news_description'] ?? '',
      newsImage: map['news_image'] ?? '',
      newsDate: DateTime.parse(map['news_date']),
      username: map['user_name'] ?? '',
      userId: int.parse(map['user_id'] ?? '0'),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsListModel.fromJson(String source) =>
      NewsListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewsListModel(id: $id, newsTitle: $newsTitle, newsDescription: $newsDescription, newsImage: $newsImage, newsDate: $newsDate, username: $username, user_id: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsListModel &&
        other.id == id &&
        other.newsTitle == newsTitle &&
        other.newsDescription == newsDescription &&
        other.newsImage == newsImage &&
        other.newsDate == newsDate &&
        other.username == username &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        newsTitle.hashCode ^
        newsDescription.hashCode ^
        newsImage.hashCode ^
        newsDate.hashCode ^
        username.hashCode ^
        userId.hashCode;
  }
}

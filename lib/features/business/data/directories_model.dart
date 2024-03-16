import 'dart:convert';

class DirectoriesModel {
  final int userId;
  final String username;
  final String userImage;
  final String userType;
  String? businessName;

  DirectoriesModel({
    required this.userId,
    required this.username,
    required this.userImage,
    required this.userType,
    this.businessName,
  });

  DirectoriesModel copyWith({
    int? userId,
    String? username,
    String? userImage,
    String? userType,
    String? businessName,
  }) {
    return DirectoriesModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      userImage: userImage ?? this.userImage,
      userType: userType ?? this.userType,
      businessName: businessName ?? this.businessName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user_id': userId});
    result.addAll({'user name': username});
    result.addAll({'user_image': userImage});
    result.addAll({'user_type': userType});
    if (businessName != null) {
      result.addAll({'business_name': businessName});
    }

    return result;
  }

  factory DirectoriesModel.fromMap(Map<String, dynamic> map) {
    return DirectoriesModel(
      userId: map['user_id']?.toInt() ?? 0,
      username: map['user_name'] ?? '',
      userImage: map['user_image'] ?? '',
      userType: map['user_type'] ?? '',
      businessName: map['business_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DirectoriesModel.fromJson(String source) =>
      DirectoriesModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DirectoriesModel(userId: $userId, username: $username, userImage: $userImage, userType: $userType, businessName: $businessName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DirectoriesModel &&
        other.userId == userId &&
        other.username == username &&
        other.userImage == userImage &&
        other.userType == userType &&
        other.businessName == businessName;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        username.hashCode ^
        userImage.hashCode ^
        userType.hashCode ^
        businessName.hashCode;
  }
}

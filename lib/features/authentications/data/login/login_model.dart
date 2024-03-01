class User {
  final String accessToken;
  final String refreshToken;
  final String userType;

  User({
    required this.accessToken,
    required this.refreshToken,
    required this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      userType: json['user_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'user_type': userType,
    };
  }
}

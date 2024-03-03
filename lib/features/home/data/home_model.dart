import 'dart:convert';

class Home {
  final String userName;

  Home({
    required this.userName,
  });

  Home copyWith({
    String? userName,
  }) {
    return Home(
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userName': userName});

    return result;
  }

  factory Home.fromMap(Map<String, dynamic> map) {
    return Home(
      userName: map['userName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Home.fromJson(String source) => Home.fromMap(json.decode(source));

  @override
  String toString() => 'Home(userName: $userName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Home && other.userName == userName;
  }

  @override
  int get hashCode => userName.hashCode;
}

import 'dart:convert';

class SignupModel {
  final String otpKey;
  final String email;

  SignupModel({
    required this.otpKey,
    required this.email,
  });

  SignupModel copyWith({
    String? otpKey,
    String? email,
  }) {
    return SignupModel(
      otpKey: otpKey ?? this.otpKey,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'otp_key': otpKey});
    result.addAll({'email': email});

    return result;
  }

  factory SignupModel.fromMap(Map<String, dynamic> map) {
    return SignupModel(
      otpKey: map['otp_key'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupModel.fromJson(String source) =>
      SignupModel.fromMap(json.decode(source));

  @override
  String toString() => 'SignupModel(otp_key: $otpKey, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignupModel &&
        other.otpKey == otpKey &&
        other.email == email;
  }

  @override
  int get hashCode => otpKey.hashCode ^ email.hashCode;
}

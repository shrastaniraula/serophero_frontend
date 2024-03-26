import 'dart:convert';

class ViewProfileModel {
  final int userId;
  final String userFullname;
  final String userName;
  final String userLocation;
  final String userContact;
  final String userEmail;
  final String userImage;
  final String userType;
  final String authorityType;
  final String businessName;
  final String businessDescription;
  ViewProfileModel({
    required this.userId,
    required this.userFullname,
    required this.userName,
    required this.userLocation,
    required this.userContact,
    required this.userEmail,
    required this.userImage,
    required this.userType,
    required this.authorityType,
    required this.businessName,
    required this.businessDescription,
  });

  ViewProfileModel copyWith({
    int? userId,
    String? userFullname,
    String? userName,
    String? userLocation,
    String? userContact,
    String? userEmail,
    String? userImage,
    String? userType,
    String? authorityType,
    String? businessName,
    String? businessDescription,
  }) {
    return ViewProfileModel(
      userId: userId ?? this.userId,
      userFullname: userFullname ?? this.userFullname,
      userName: userName ?? this.userName,
      userLocation: userLocation ?? this.userLocation,
      userContact: userContact ?? this.userContact,
      userEmail: userEmail ?? this.userEmail,
      userImage: userImage ?? this.userImage,
      userType: userType ?? this.userType,
      authorityType: authorityType ?? this.authorityType,
      businessName: businessName ?? this.businessName,
      businessDescription: businessDescription ?? this.businessDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userFullname': userFullname,
      'userName': userName,
      'userLocation': userLocation,
      'userContact': userContact,
      'userEmail': userEmail,
      'userImage': userImage,
      'userType': userType,
      'authorityType': authorityType,
      'businessName': businessName,
      'businessDescription': businessDescription,
    };
  }

  factory ViewProfileModel.fromMap(Map<String, dynamic> map) {
    return ViewProfileModel(
      userId: map['user_id'] as int,
      userFullname: map['user_fullname'] as String,
      userName: map['user_name'] as String,
      userLocation: map['user_location'] as String,
      userContact: map['user_contact'] as String,
      userEmail: map['user_email'] as String,
      userImage: map['user_image'] ?? '',
      userType: map['user_type'] as String,
      authorityType: map['authority_role'] ?? '',
      businessName: map['business_name'] ?? '',
      businessDescription: map['business_description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ViewProfileModel.fromJson(String source) =>
      ViewProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ViewProfileModel(userId: $userId, userFullname: $userFullname, userName: $userName, userLocation: $userLocation, userContact: $userContact, userEmail: $userEmail, userImage: $userImage, userType: $userType, authorityType: $authorityType, businessName: $businessName, businessDescription: $businessDescription)';
  }

  @override
  bool operator ==(covariant ViewProfileModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.userFullname == userFullname &&
        other.userName == userName &&
        other.userLocation == userLocation &&
        other.userContact == userContact &&
        other.userEmail == userEmail &&
        other.userImage == userImage &&
        other.userType == userType &&
        other.authorityType == authorityType &&
        other.businessName == businessName &&
        other.businessDescription == businessDescription;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userFullname.hashCode ^
        userName.hashCode ^
        userLocation.hashCode ^
        userContact.hashCode ^
        userEmail.hashCode ^
        userImage.hashCode ^
        userType.hashCode ^
        authorityType.hashCode ^
        businessName.hashCode ^
        businessDescription.hashCode;
  }
}

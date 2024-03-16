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

  ViewProfileModel(
    this.userId,
    this.userFullname,
    this.userName,
    this.userLocation,
    this.userContact,
    this.userEmail,
    this.userImage,
    this.userType,
    this.authorityType,
    this.businessName,
    this.businessDescription,
  );

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
      userId ?? this.userId,
      userFullname ?? this.userFullname,
      userName ?? this.userName,
      userLocation ?? this.userLocation,
      userContact ?? this.userContact,
      userEmail ?? this.userEmail,
      userImage ?? this.userImage,
      userType ?? this.userType,
      authorityType ?? this.authorityType,
      businessName ?? this.businessName,
      businessDescription ?? this.businessDescription,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user_id': userId});
    result.addAll({'user_fullname': userFullname});
    result.addAll({'user_name': userName});
    result.addAll({'user_location': userLocation});
    result.addAll({'user_contact': userContact});
    result.addAll({'user_email': userEmail});
    result.addAll({'user_image': userImage});
    result.addAll({'user_type': userType});
    result.addAll({'authority_role': authorityType});
    result.addAll({'business_name': businessName});

    result.addAll({'business_description': businessDescription});

    return result;
  }

  factory ViewProfileModel.fromMap(Map<String, dynamic> map) {
    return ViewProfileModel(
      map['user_id']?.toInt() ?? 0,
      map['user_fullname'] ?? '',
      map['user_name'] ?? '',
      map['user_location'] ?? '',
      map['user_contact'] ?? '',
      map['user_email'] ?? '',
      map['user_image'] ?? '',
      map['user_type'] ?? '',
      map['authority_type'] ?? '',
      map['business_name'],
      map['business_description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ViewProfileModel.fromJson(String source) =>
      ViewProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ViewProfileModel(userId: $userId, userFullname: $userFullname, userName: $userName, userLocation: $userLocation, userContact: $userContact, userEmail: $userEmail, userImage: $userImage, userType: $userType, authorityType: $authorityType, businessName: $businessName, businessDescription: $businessDescription)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ViewProfileModel &&
        other.userId == userId &&
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

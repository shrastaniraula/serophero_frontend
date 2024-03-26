import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:serophero/features/business/data/directories_model.dart';
import 'package:serophero/features/events/data/event_model.dart';
import 'package:serophero/features/profile/data/view_profile_model.dart';

class HomeModel {
  final ViewProfileModel profile;
  final List<DirectoriesModel> businesses;
  final List<EventListModel> events;

  HomeModel({
    required this.profile,
    required this.businesses,
    required this.events,
  });

  HomeModel copyWith({
    ViewProfileModel? profile,
    List<DirectoriesModel>? businesses,
    List<EventListModel>? events,
  }) {
    return HomeModel(
      profile: profile ?? this.profile,
      businesses: businesses ?? this.businesses,
      events: events ?? this.events,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'profile': profile.toMap()});
    result.addAll({'businesses': businesses.map((x) => x.toMap()).toList()});
    result.addAll({'events': events.map((x) => x.toMap()).toList()});

    return result;
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    print("in model");
    print(map);
    return HomeModel(
      profile: ViewProfileModel.fromMap(map['user_details'] ?? {}),
      businesses: (map['business_details'] != null)
          ? List<DirectoriesModel>.from(
              map['business_details']!.map((x) => DirectoriesModel.fromMap(x)))
          : [],
      events: (map['event_details'] != null)
          ? List<EventListModel>.from(
              map['event_details']!.map((x) => EventListModel.fromMap(x)))
          : [],
    );
    // return HomeModel(
    //   profile: ViewProfileModel.fromMap(map['user_details']),
    //   businesses: List<DirectoriesModel>.from(
    //       map['business_details']?.map((x) => DirectoriesModel.fromMap(x))),
    //   events: List<EventListModel>.from(
    //       map['event_details']?.map((x) => EventListModel.fromMap(x))),
    // );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'HomeModel(profile: $profile, businesses: $businesses, events: $events)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeModel &&
        other.profile == profile &&
        listEquals(other.businesses, businesses) &&
        listEquals(other.events, events);
  }

  @override
  int get hashCode => profile.hashCode ^ businesses.hashCode ^ events.hashCode;
}

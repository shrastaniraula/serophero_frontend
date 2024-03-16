part of 'view_profile_bloc.dart';

abstract class ViewProfileEvent {}

class ProfilePageOpened extends ViewProfileEvent {
  final int user;

  ProfilePageOpened({
    required this.user,
  });
}

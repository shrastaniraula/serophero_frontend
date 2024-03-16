part of 'view_profile_bloc.dart';

abstract class ViewProfileState {}

class ViewProfileInitial extends ViewProfileState {}

class ViewProfileLoading extends ViewProfileState {}

class ViewProfileSuccess extends ViewProfileState {
  final ViewProfileModel user_data;

  ViewProfileSuccess({required this.user_data});
}

class ViewProfileFailure extends ViewProfileState {
  final String error;

  ViewProfileFailure({required this.error});
}

class TokenExpired extends ViewProfileState {}

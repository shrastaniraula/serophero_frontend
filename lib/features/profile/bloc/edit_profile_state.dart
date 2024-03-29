part of 'edit_profile_bloc.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  EditProfileSuccess();
}

class EditProfileFailure extends EditProfileState {
  final String error;

  EditProfileFailure({required this.error});
}

class TokenExpired extends EditProfileState {}

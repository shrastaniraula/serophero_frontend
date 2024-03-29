part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent {}

class UpdateProfileEvent extends EditProfileEvent {
  final String lastname;
  final String firstname;
  final String contact;
  final String location;
  final String username;
  final File? image;
  final String name;
  final String description;

  UpdateProfileEvent({
    required this.name,
    required this.description,
    required this.lastname,
    required this.firstname,
    required this.contact,
    required this.location,
    required this.username,
    required this.image,
  });
}

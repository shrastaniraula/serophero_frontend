import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/profile/data/edit_profile_repo.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfileEvent>((event, emit) => getProfileView(event, emit));
  }

  void getProfileView(
      EditProfileEvent event, Emitter<EditProfileState> emit) async {
    if (event is UpdateProfileEvent) {
      print("object");
      emit(EditProfileLoading());
      try {
        await EditProfileRepo().updateProfile(
            lastname: event.lastname,
            firstname: event.firstname,
            contact: event.contact,
            username: event.username,
            image: event.image,
            location: event.location,
            name: event.name,
            description: event.description);

        emit(EditProfileSuccess());
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(EditProfileFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(EditProfileFailure(
                  error: error.response?.data["message"][0]));
            }
          } else {
            print(error);
            emit(EditProfileFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          print(error);

          emit(EditProfileFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    }
  }
}

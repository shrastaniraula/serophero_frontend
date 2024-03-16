import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/business/data/directories_model.dart';
import 'package:serophero/features/business/data/directories_repo.dart';

part 'directories_event.dart';
part 'directories_state.dart';

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {
  BusinessBloc() : super(DirectoriesInitial()) {
    on<BusinessEvent>((event, emit) => getNewsList(event, emit));
  }

  void getNewsList(BusinessEvent event, Emitter<BusinessState> emit) async {
    if (event is DirectoriesPageOpened) {
      emit(DirectoriesLoading());
      try {
        List<DirectoriesModel> directorieslist =
            await BusinessRepo().getDirectories();
        emit(DirectoriesSuccess(directorieslist: directorieslist));
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(DirectoriesFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(DirectoriesFailure(
                  error: error.response?.data["message"][0]));
            }
          } else {
            emit(DirectoriesFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          emit(DirectoriesFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    }
  }
}

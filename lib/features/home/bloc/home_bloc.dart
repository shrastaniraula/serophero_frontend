import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/home/data/home_model.dart';
import 'package:serophero/features/home/data/home_repo.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) => getHome(event, emit));
  }

  void getHome(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomePageOpened) {
      emit(HomeLoading());
      try {
        HomeModel homeData = await HomeRepo().getHomeData();

        emit(HomeSuccess(homeData: homeData));
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(HomeFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(HomeFailure(error: error.response?.data["message"][0]));
            }
          } else {
            emit(HomeFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          print(error);
          emit(HomeFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    }
  }
}

import 'dart:io';

import 'package:serophero/features/events/data/event_model.dart';
import 'package:serophero/features/events/data/event_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventListInitial()) {
    on<EventEvent>((event, emit) => getEventList(event, emit));
  }

  void getEventList(EventEvent event, Emitter<EventState> emit) async {
    if (event is EventPageOpened) {
      emit(EventListLoading());
      try {
        List<EventListModel> eventlist = await EventListRepo().getEventList();
        emit(EventListSuccess(eventlist: eventlist));
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(EventListFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(EventListFailure(error: error.response?.data["message"][0]));
            }
          } else {
            print(error);
            emit(EventListFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          print(error);

          emit(EventListFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    } else if (event is PostEvents) {
      emit(EventListLoading());
      try {
        await EventListRepo().addEvent(
            eventHeading: event.eventHeading,
            eventDescription: event.eventDescription,
            image: event.image,
            eventTime: event.eventTime,
            eventLocation: event.eventLocation,
            allowed: event.allowed);
        print("helooo bloc bloc");
        print(event.allowed);
        emit(EventPostSuccess());
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(EventListFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(EventListFailure(error: error.response?.data["message"][0]));
            }
          } else {
            emit(EventListFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          emit(EventListFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    }
  }
}

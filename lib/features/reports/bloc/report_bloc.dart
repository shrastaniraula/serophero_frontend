import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/reports/data/report_repo.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportInitial()) {
    on<ReportEvent>((event, emit) => getEventList(event, emit));
  }

  void getEventList(ReportEvent event, Emitter<ReportState> emit) async {
    if (event is AddReport) {
      emit(ReportLoading());
      try {
        await ReportRepo()
            .report(reason: event.reason, type: event.type, id: event.id);

        emit(ReportSuccess());
      } catch (error) {
        if (error is DioException) {
          if (error.response != null) {
            final statusCode = error.response!.statusCode;
            if (statusCode == 522) {
              emit(ReportFailure(
                  error: 'Connection timed out. Please try again later.'));
            } else if (statusCode == 401) {
              emit(TokenExpired());
            } else {
              emit(ReportFailure(error: error.response?.data["message"][0]));
            }
          } else {
            emit(ReportFailure(
                error: "Something went wrong, please try again later."));
          }
        } else {
          emit(ReportFailure(
              error: "Something went wrong, please try again laterrrr."));
        }
      }
    }
  }
}

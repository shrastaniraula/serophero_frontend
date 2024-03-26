part of 'report_bloc.dart';

abstract class ReportState {}

final class ReportInitial extends ReportState {}

final class ReportLoading extends ReportState {}

final class ReportFailure extends ReportState {
  final String error;

  ReportFailure({required this.error});
}

final class TokenExpired extends ReportState {}

final class ReportSuccess extends ReportState {
  ReportSuccess();
}

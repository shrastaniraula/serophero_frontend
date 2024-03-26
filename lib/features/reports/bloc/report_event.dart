part of 'report_bloc.dart';

abstract class ReportEvent {}

class AddReport extends ReportEvent {
  final String reason;
  final String type;
  final int id;

  AddReport({required this.reason, required this.type, required this.id});
}

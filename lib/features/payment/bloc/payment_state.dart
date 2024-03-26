part of 'payment_bloc.dart';

abstract class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoading extends PaymentState {}

final class PaymentHistorySuccess extends PaymentState {
  final List<PaymentModel> paymentHistoryList;

  PaymentHistorySuccess({required this.paymentHistoryList});
}

final class PaymentMadeSuccess extends PaymentState {}

final class PaymentFailure extends PaymentState {
  final String error;

  PaymentFailure({required this.error});
}

final class TokenExpired extends PaymentState {}

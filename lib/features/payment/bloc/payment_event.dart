part of 'payment_bloc.dart';

abstract class PaymentEvent {}

class PaymentHistoryPageOpened extends PaymentEvent {
  PaymentHistoryPageOpened();
}

class PaymentMade extends PaymentEvent {
  final String token;
  final String transactionId;
  final int amount;
  final int userId;
  final String remarks;

  PaymentMade({
    required this.token,
    required this.transactionId,
    required this.amount,
    required this.userId,
    required this.remarks,
  });
}

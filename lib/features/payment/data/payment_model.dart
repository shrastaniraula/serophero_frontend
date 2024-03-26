import 'dart:convert';

class PaymentModel {
  String transactionId;
  String token;
  int amount;
  int receiver;
  String receiverName;
  String receiverContact;
  DateTime paymentDate;
  String remarks;
  PaymentModel({
    required this.transactionId,
    required this.token,
    required this.amount,
    required this.receiver,
    required this.receiverName,
    required this.receiverContact,
    required this.paymentDate,
    required this.remarks,
  });

  PaymentModel copyWith({
    String? transactionId,
    String? token,
    int? amount,
    int? receiver,
    String? receiverName,
    String? receiverContact,
    DateTime? paymentDate,
    String? remarks,
  }) {
    return PaymentModel(
      transactionId: transactionId ?? this.transactionId,
      token: token ?? this.token,
      amount: amount ?? this.amount,
      receiver: receiver ?? this.receiver,
      receiverName: receiverName ?? this.receiverName,
      receiverContact: receiverContact ?? this.receiverContact,
      paymentDate: paymentDate ?? this.paymentDate,
      remarks: remarks ?? this.remarks,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'transaction_id': transactionId});
    result.addAll({'token': token});
    result.addAll({'amount': amount});
    result.addAll({'receiver': receiver});
    result.addAll({'receiver_name': receiverName});
    result.addAll({'receiver_contact': receiverContact});
    result.addAll({'payment_datetime': paymentDate.millisecondsSinceEpoch});
    result.addAll({'remarks': remarks});

    return result;
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      transactionId: map['transaction_id'] ?? '',
      token: map['token'] ?? '',
      amount: map['amount'] is int
          ? map['amount']
          : int.parse(map['amount'] ?? '0'),
      receiver: map['receiver'] is int
          ? map['receiver']
          : int.parse(map['receiver'] ?? '0'),
      receiverName: map['receiver_name'] ?? '',
      receiverContact: map['receiver_contact'] ?? '',
      paymentDate: DateTime.parse(map['payment_datetime']),
      remarks: map['remarks'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) =>
      PaymentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentModel(transactionId: $transactionId, token: $token, amount: $amount, receiver: $receiver, receiverName: $receiverName, receiverContact: $receiverContact, paymentDate: $paymentDate, remarks: $remarks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentModel &&
        other.transactionId == transactionId &&
        other.token == token &&
        other.amount == amount &&
        other.receiver == receiver &&
        other.receiverName == receiverName &&
        other.receiverContact == receiverContact &&
        other.paymentDate == paymentDate &&
        other.remarks == remarks;
  }

  @override
  int get hashCode {
    return transactionId.hashCode ^
        token.hashCode ^
        amount.hashCode ^
        receiver.hashCode ^
        receiverName.hashCode ^
        receiverContact.hashCode ^
        paymentDate.hashCode ^
        remarks.hashCode;
  }
}

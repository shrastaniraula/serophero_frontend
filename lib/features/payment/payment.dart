// import 'package:bookme/logic/bloc_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:serophero/features/payment/bloc/payment_bloc.dart';

class KhaltiPaymentGateway {
  void paymentGateway(
      BuildContext context, int userId, int amount, String remarks) {
    final config = PaymentConfig(
      amount: amount,
      productIdentity: userId.toString(),
      productName: remarks,
    );

    // print(config.productName);
    KhaltiScope.of(context).pay(
      config: config,
      preferences: [
        PaymentPreference.khalti,
        // PaymentPreference.eBanking,
        // PaymentPreference.connectIPS
      ],
      onSuccess: (successModel) {
        print(successModel);
        context.read<PaymentBloc>().add(PaymentMade(
            transactionId: successModel.idx,
            token: successModel.token,
            amount: successModel.amount,
            userId: int.parse(successModel.productIdentity),
            remarks: successModel.productName));
      },
      onCancel: () {},
      onFailure: (paymentFailure) {
        // print("failure");
      },
    );
  }
}

// import 'package:bookme/logic/bloc_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:serophero/features/payment/bloc/payment_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/snackbar.dart';

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

        MySnackbar.show(
          context,
          title: "Payment Success",
          message: "Your payment was successful.",
          type: SnackbarType.success,
        );

        Navigator.push(
            context,
            GeneratedRoute().onGeneratedRoute(
              RouteSettings(name: '/home'),
            ));
      },
      onCancel: () {},
      onFailure: (paymentFailure) {
        // print("failure");
      },
    );
  }
}

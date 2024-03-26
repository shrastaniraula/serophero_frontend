import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/payment/bloc/payment_bloc.dart';
import 'package:serophero/features/payment/data/payment_model.dart';

class TransactionHistoryPage extends StatefulWidget {
  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  final PaymentBloc paymentBloc = PaymentBloc();

  @override
  void initState() {
    paymentBloc.add(PaymentHistoryPageOpened());
    super.initState();
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        bloc: paymentBloc,
        builder: (context, state) {
          if (state is PaymentLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PaymentHistorySuccess) {
            return _buildTransactionList(state.paymentHistoryList);
          } else if (state is PaymentFailure) {
            return Center(child: Text(state.error));
          } else {
            return Container(); // Handle other states if needed
          }
        },
      ),
    );
  }

  Widget _buildTransactionList(List<PaymentModel> paymentHistoryList) {
    return ListView.builder(
      itemCount: paymentHistoryList.length,
      itemBuilder: (context, index) {
        final payment = paymentHistoryList[index];
        return ListTile(
          title: Text('Transaction ID: ${payment.transactionId}'),
          subtitle: Text('Amount: ${payment.amount}'),
          trailing: Text('Date: ${payment.paymentDate}'),
        );
      },
    );
  }
}

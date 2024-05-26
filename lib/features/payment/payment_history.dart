import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/payment/bloc/payment_bloc.dart';
import 'package:serophero/features/payment/data/payment_model.dart';
import 'package:serophero/utils/datetime_utils.dart';

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

        return Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  '${payment.amount}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      payment.receiverName,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      payment.receiverContact,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  payment.remarks,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(
                child: Text(
                  DateTimeUtils.formatRelativeTime(payment.paymentDate),
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
            ],
          ),
        );
        // return ListTile(
        //     leading: Text('Receiver: ${payment.receiverName}'),
        //     title: Text('Remarks: ${payment.remarks}'),
        //     subtitle: Text('Amount: ${payment.amount}'),
        //     trailing: Text(
        //       DateTimeUtils.formatRelativeTime(payment.paymentDate),
        //     ));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/business/bloc/directories_bloc.dart';
import 'package:serophero/features/payment/payment.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';

class PaymentInitiation extends StatefulWidget {
  @override
  _PaymentInitiationState createState() => _PaymentInitiationState();
}

class _PaymentInitiationState extends State<PaymentInitiation> {
  final BusinessBloc directoriesBloc = BusinessBloc();
  String selectedUserId = "43";
  TextEditingController amountController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  @override
  void initState() {
    directoriesBloc.add(DirectoriesPageOpened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<BusinessBloc, BusinessState>(
                bloc: directoriesBloc,
                builder: (context, state) {
                  if (state is DirectoriesSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Select User",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.tertiary)),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedUserId,
                          dropdownColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          focusColor: Theme.of(context).colorScheme.tertiary,
                          // iconEnabledColor: Colors.amber,

                          hint: const Text('Select User'),
                          onChanged: (value) {
                            setState(() {
                              selectedUserId = value!;
                            });
                          },
                          items: state.directorieslist
                              .map<DropdownMenuItem<String>>((directories) {
                            return DropdownMenuItem<String>(
                              value: directories.userId.toString(),
                              child: Text(
                                directories.username,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  } else if (state is DirectoriesFailure) {
                    return const Center(child: Text("Failed to load users"));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: remarksController,
                decoration: const InputDecoration(labelText: 'Remarks'),
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                backgroundColorBtn: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  // Proceed with payment using selectedUserId, amountController.text, and remarksController.text
                  // Use selectedUserId, amountController.text, and remarksController.text to make the payment

                  KhaltiPaymentGateway khaltiGateway =
                      new KhaltiPaymentGateway();
                  int amount = int.parse(amountController.text) * 100;
                  int user = int.parse(selectedUserId);

                  khaltiGateway.paymentGateway(
                      context, user, amount, remarksController.text);
                },
                text: 'Proceed',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    directoriesBloc.close();
    super.dispose();
  }
}

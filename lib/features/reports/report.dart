import 'package:flutter/material.dart';
import 'package:serophero/features/reports/bloc/report_bloc.dart';
import 'package:serophero/themes/theme_data.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Report extends StatefulWidget {
  final int id;
  final String type;

  const Report({super.key, required this.id, required this.type});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  TextEditingController reportDescController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Report")),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "Remember to report only the truth and not due to any personal issues. Your reports will be supervised by admin. Any suspicious activity can risk you being on blacklist.",
                style: small_text_style,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              hintText: "Description",
              controller: reportDescController,
              context: context,
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
                text: "Submit",
                backgroundColorBtn: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  context.read<ReportBloc>().add(AddReport(
                      reason: reportDescController.text.trim(),
                      id: widget.id,
                      type: widget.type));
                  reportDescController.clear();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Reported Successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  });
                }),
          ],
        ),
      )),
    );
  }
}

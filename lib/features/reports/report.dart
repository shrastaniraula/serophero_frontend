import 'package:flutter/material.dart';
import 'package:serophero/features/reports/bloc/report_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/themes/theme_data.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/widgets/snackbar.dart';

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
        title: Center(child: Text("Report ${widget.type}")),
      ),
      body: BlocListener<ReportBloc, ReportState>(
        listener: (context, state) {
          if (state is ReportSuccess) {
            MySnackbar.show(
              context,
              title: "Reported ${widget.type} Successfully",
              message: "The ${widget.type} is reported successfully",
              type: SnackbarType.success,
            );
          }
          if (state is ReportFailure) {
            MySnackbar.show(
              context,
              title: "Something went wrong",
              message: "Try again later",
              type: SnackbarType.error,
            );
          }
        },
        child: SafeArea(
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
              BlocBuilder<ReportBloc, ReportState>(
                builder: (context, state) {
                  return CustomElevatedButton(
                      isLoading: state is ReportLoading,
                      text: "Submit",
                      backgroundColorBtn: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        context.read<ReportBloc>().add(AddReport(
                            reason: reportDescController.text.trim(),
                            id: widget.id,
                            type: widget.type));
                        reportDescController.clear();
                      });
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}

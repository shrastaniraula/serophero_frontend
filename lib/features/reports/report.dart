import 'package:flutter/material.dart';
import 'package:serophero/themes/theme_data.dart';
// import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  TextEditingController reportDescController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
            const Text("Report"),
            const SizedBox(),
          ],
        ),
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
            SizedBox(height: 20),
            CustomTextFormField(
              hintText: "Description",
              controller: reportDescController,
              context: context,
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
                text: "Submit",
                backgroundColorBtn: Theme.of(context).colorScheme.primary,
                onPressed: () {}),
          ],
        ),
      )),
    );
  }
}

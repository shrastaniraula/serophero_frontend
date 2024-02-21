import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/help_text.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
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
              child: const Icon(
                Icons.arrow_back,
                // color: Colors.black,
              ),
            ),
            const Text(
              "Verify OTP",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox()
          ],
        ),
      ),
      bottomNavigationBar: HelpText(
          firstText: "Didn't get the code? ",
          secondText: "Resend it?",
          onTapp: () {
            Navigator.push(
                context,
                GeneratedRoute().onGeneratedRoute(
                  const RouteSettings(arguments: '', name: '/login'),
                ));
          }),
      body: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              // Information text
              Container(
                // width: 308,
                margin: EdgeInsets.only(left: 11, right: 10),
                child: const Text(
                  "We’ve sent you the access code via email. Please enter the code within 90 seconds.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              PinCodeTextField(
                appContext: context,
                length: 6,
                // controller: otpController,
                keyboardType: TextInputType.number,
                cursorColor: Theme.of(context).colorScheme.tertiary,
                autoDisposeControllers: true,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  activeColor: Theme.of(context).colorScheme.primary,
                  selectedColor: Theme.of(context).colorScheme.secondary,
                  inactiveColor: Theme.of(context).colorScheme.primary,
                ),
                onChanged: (value) {
                  // Handle onChanged event
                },
                onCompleted: (value) {
                  // Handle onCompleted event
                },
              ),
              SizedBox(height: 20),
              CustomElevatedButton(
                text: "Verify",
                backgroundColorBtn: const Color.fromRGBO(80, 75, 166, 1),
                onPressed: () {},
              ),
            ],
          )),
    );
  }
}

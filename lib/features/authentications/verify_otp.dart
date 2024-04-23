import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:serophero/features/authentications/bloc/otp_pass/otp_pass_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:serophero/widgets/help_text.dart';
import 'package:serophero/widgets/snackbar.dart';

// ignore: must_be_immutable
class VerifyOtpPage extends StatelessWidget {
  final String otpKey;
  final String email;
  final String purpose;
  VerifyOtpPage(
      {super.key,
      required this.otpKey,
      required this.email,
      required this.purpose});

  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpPassBloc, OtpPassState>(
        listener: (context, state) {
          if (state is OtpPassFailure) {
            MySnackbar.show(
              context,
              title: "OTP Verification Error",
              message: state.error,
              type: SnackbarType.error,
            );
          }
          if (state is OtpPassSuccess) {
            MySnackbar.show(
              context,
              title: "Successfully Completed",
              message: "Please enter credentials to login.",
              type: SnackbarType.success,
            );

            Navigator.pushReplacement(
              context,
              GeneratedRoute().onGeneratedRoute(
                const RouteSettings(name: '/login'),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Center(child: Text("Verify OTP"))),
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
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                children: [
                  // Information text
                  Container(
                    // width: 308,
                    margin: const EdgeInsets.only(left: 11, right: 10),
                    child: const Text(
                      "We’ve sent you the access code via email. Please enter the code within 5 minutes.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    cursorColor: Theme.of(context).colorScheme.tertiary,
                    autoDisposeControllers: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
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

                  purpose == "reset"
                      ? Column(
                          children: [
                            const SizedBox(height: 20),
                            CustomTextFormField(
                              controller: passwordController,
                              hintText: "New Password",
                              context: context,
                            ),
                            const SizedBox(height: 40),
                          ],
                        )
                      : const SizedBox(height: 40),
                  CustomElevatedButton(
                    text: "Verify",
                    backgroundColorBtn: const Color.fromRGBO(80, 75, 166, 1),
                    onPressed: () {
                      context.read<OtpPassBloc>().add(
                            OtpPassClicked(
                                email: email,
                                newPassword: passwordController.text.trim(),
                                enteredOtp: otpController.text.trim(),
                                otpKey: otpKey,
                                purpose: purpose),
                          );
                    },
                  ),
                ],
              )),
        ));
  }
}

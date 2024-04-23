import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/authentications/bloc/signup/signup_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:serophero/widgets/snackbar.dart';
import 'package:serophero/widgets/welcome.dart';

// ignore: must_be_immutable
class EmailPassword extends StatelessWidget {
  EmailPassword({super.key});

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              duration: const Duration(seconds: 1),
            ));
          }
          if (state is EmailPasswordSuccess) {
            MySnackbar.show(
              context,
              title: "OTP Sent",
              message: "The OTP has been sent, check your email.",
              type: SnackbarType.info,
            );

            Navigator.pushReplacement(
              context,
              GeneratedRoute().onGeneratedRoute(
                RouteSettings(arguments: {
                  'otp_key': state.signuplist.otpKey,
                  'email': state.signuplist.email,
                  'purpose': 'reset'
                }, name: '/otp'),
              ),
            );
          }
        },
        child: Scaffold(
          // appBar: AppBar(title: const Center(child: Text("Change Password"))),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WelcomeMessage(
                    welcomeText: "Enter your email for password reset.",
                  ),
                  const SizedBox(height: 80),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: "Email",
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    text: "Send OTP",
                    backgroundColorBtn: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      context.read<SignupBloc>().add(
                            ForgotPassEmailClicked(
                                email: emailController.text.trim()),
                          );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

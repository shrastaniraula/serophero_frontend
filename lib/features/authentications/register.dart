import 'package:flutter/material.dart';
import 'package:serophero/features/authentications/bloc/signup/signup_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:serophero/widgets/help_text.dart';
import 'package:serophero/widgets/snackbar.dart';
import 'package:serophero/widgets/welcome.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _showPassword = false;
  TextEditingController lastnameControler = TextEditingController();
  TextEditingController firstnameControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupFailure) {
            if (mounted) {
              MySnackbar.show(
                context,
                title: "Error",
                message: state.error,
                type: SnackbarType.error,
              );
            }
          }
          if (state is SignupSuccess) {
            if (mounted) {
              MySnackbar.show(
                context,
                title: "Enter OTP for validation",
                message:
                    "Please enter the OTP sent to your email for successful registration.",
                type: SnackbarType.info,
              );
            }
            Navigator.pushReplacement(
              context,
              GeneratedRoute().onGeneratedRoute(
                RouteSettings(arguments: {
                  'otp_key': state.signuplist.otpKey,
                  'email': state.signuplist.email,
                  'purpose': 'signup'
                }, name: '/otp'),
              ),
            );
          }
        },
        child: Scaffold(
          bottomNavigationBar: HelpText(
            onTapp: () {
              Navigator.push(
                  context,
                  GeneratedRoute().onGeneratedRoute(
                    const RouteSettings(arguments: '', name: '/login'),
                  ));
            },
            firstText: "Already have an account? ",
            secondText: 'Log in',
          ),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WelcomeMessage(
                    welcomeText:
                        "Hey there, let's create an account for you !!"),
                const SizedBox(height: 40),
                CustomTextFormField(
                  hintText: "First Name",
                  context: context,
                  controller: firstnameControler,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: "Last Name",
                  context: context,
                  controller: lastnameControler,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: "Email Address",
                  context: context,
                  controller: emailControler,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: "Password",
                  context: context,
                  controller: passwordController,
                  obscureText: !_showPassword,
                  prefixConstraints: const BoxConstraints(),
                  suffix: buildPasswordToggleIcon(),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: "Confirm Password",
                  context: context,
                  // controller: idcontroller,
                  obscureText: !_showPassword,
                  prefixConstraints: const BoxConstraints(),
                  suffix: buildPasswordToggleIcon(),
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: "Sign Up",
                  backgroundColorBtn: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    context.read<SignupBloc>().add(
                          SignupButtonClicked(
                              firstname: firstnameControler.text.trim(),
                              lastname: lastnameControler.text.trim(),
                              email: emailControler.text.trim(),
                              password: passwordController.text.trim()),
                        );
                  },
                ),
              ],
            ),
          )),
        ));
  }

  Widget buildPasswordToggleIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showPassword = !_showPassword;
        });
      },
      child: Icon(
        _showPassword ? Icons.visibility : Icons.visibility_off,
        size: 20,
        color: Colors.grey,
      ),
    );
  }
}

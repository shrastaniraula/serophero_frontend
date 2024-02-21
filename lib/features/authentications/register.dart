import 'package:flutter/material.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:serophero/widgets/help_text.dart';
import 'package:serophero/widgets/welcome.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                welcomeText: "Hey there, let's create an account for you !!"),
            const SizedBox(height: 40),
            CustomTextFormField(
              hintText: "First Name",
              context: context,
              // controller: idcontroller,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              hintText: "Last Name",
              context: context,

              // controller: idcontroller,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              hintText: "Email Address",
              context: context,

              // controller: idcontroller,
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              hintText: "Password",
              context: context,

              // controller: idcontroller,
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
            SizedBox(height: 20),
            CustomElevatedButton(
              text: "Sign Up",
              backgroundColorBtn: Theme.of(context).colorScheme.primary,
              onPressed: () {},
            ),
          ],
        ),
      )),
    );
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:serophero/widgets/help_text.dart';
import 'package:serophero/widgets/welcome.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: HelpText(
        onTapp: () {
          Navigator.push(
              context,
              GeneratedRoute().onGeneratedRoute(
                const RouteSettings(arguments: '', name: '/signup'),
              ));
        },
        firstText: "Don't have an account? ",
        secondText: 'Sign up',
      ),
      // Padding(
      //   padding: const EdgeInsets.only(bottom: 10),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const Text(
      //         "Don't have an account?",
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           Navigator.push(
      //               context,
      //               GeneratedRoute().onGeneratedRoute(
      //                 const RouteSettings(arguments: '', name: '/signup'),
      //               ));
      //         },
      //         child: Text("Sign up",
      //             style: TextStyle(
      //               color: Theme.of(context).colorScheme.secondary,
      //             )),
      //       )
      //     ],
      //   ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WelcomeMessage(welcomeText: "Welcome back, Let's sign you in ;)"),
              const SizedBox(height: 80),
              CustomTextFormField(
                hintText: "Username",
                context: context,
                // controller: idcontroller,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                context: context,
                obscureText: !_showPassword,
                hintText: "Password",
                prefixConstraints: const BoxConstraints(),
                suffix: buildPasswordToggleIcon(),
                // controller: passwordcontroller,
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                text: "Login",
                backgroundColorBtn: Theme.of(context).colorScheme.primary,
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    GeneratedRoute().onGeneratedRoute(
                      const RouteSettings(arguments: '', name: '/signup'),
                    ),
                  );
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

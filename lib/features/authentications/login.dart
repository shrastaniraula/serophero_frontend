import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/authentications/bloc/login/login_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:serophero/widgets/help_text.dart';
import 'package:serophero/widgets/welcome.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${state.error}'),
                duration: Duration(seconds: 1),
              ));
            }
          }
          if (state is LoginSuccess) {
            Navigator.push(
              context,
              GeneratedRoute().onGeneratedRoute(
                const RouteSettings(arguments: '', name: '/home'),
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
                  const RouteSettings(arguments: '', name: '/signup'),
                ),
              );
            },
            firstText: "Don't have an account? ",
            secondText: 'Sign up',
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WelcomeMessage(
                    welcomeText: "Welcome back, Let's sign you in ;)",
                  ),
                  const SizedBox(height: 80),
                  CustomTextFormField(
                    controller: _usernameController,
                    hintText: "Username",
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _passwordController,
                    context: context,
                    obscureText: !_showPassword,
                    hintText: "Password",
                    prefixConstraints: const BoxConstraints(),
                    suffix: buildPasswordToggleIcon(),
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    text: "Login",
                    backgroundColorBtn: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      // Dispatch the LoginButtonPressed event to the BLoC
                      context.read<LoginBloc>().add(
                            LoginButtonPressed(
                              email: _usernameController.text,
                              password: _passwordController.text,
                            ),
                          );
                    },
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
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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

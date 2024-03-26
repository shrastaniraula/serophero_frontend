import 'package:flutter/material.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';
import 'package:serophero/widgets/custom_textfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text("Change Password"))),
      body: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              // Information text
              // Container(
              //   margin: EdgeInsets.only(left: 11, right: 10),
              //   child: const Text(
              //     "We’ve sent you the access code via email. Please enter the code within 90 seconds.",
              //     maxLines: 2,
              //     overflow: TextOverflow.ellipsis,
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              // const SizedBox(height: 20),

              CustomTextFormField(
                hintText: "New Password",
                context: context,
                obscureText: !_showPassword,
                prefixConstraints: const BoxConstraints(),
                suffix: buildPasswordToggleIcon(),
              ),
              SizedBox(height: 20),

              CustomTextFormField(
                hintText: "Confirm New Password",
                context: context,
                obscureText: !_showPassword,
                prefixConstraints: const BoxConstraints(),
                suffix: buildPasswordToggleIcon(),
              ),

              SizedBox(height: 20),

              //Button
              CustomElevatedButton(
                text: "Verify",
                backgroundColorBtn: Theme.of(context).colorScheme.primary,
                onPressed: () {},
              ),
            ],
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

import 'package:flutter/material.dart';
// import 'package:serophero/routes/generated_routes.dart';

// ignore: must_be_immutable
class HelpText extends StatelessWidget {
  final String firstText;
  final String secondText;
  VoidCallback? onTapp;

  HelpText(
      {required this.firstText,
      required this.secondText,
      required this.onTapp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            firstText,
            // style: Theme.of(context).textTheme.bodyText1,
          ),
          GestureDetector(
            onTap: onTapp ?? () {},
            child: Text(
              secondText,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          )
        ],
      ),
    );
  }
}

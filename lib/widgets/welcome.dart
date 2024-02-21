import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {
  final String welcomeText;

  WelcomeMessage({required this.welcomeText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: 50,
              width: 50,
              color: Theme.of(context).colorScheme.tertiary,
              image: AssetImage("assets/images/logos/communiti.png"),
            ),
            Text(
              "SeroPhero",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          welcomeText,
          // style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

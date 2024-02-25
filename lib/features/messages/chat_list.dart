import 'package:flutter/material.dart';
import 'package:serophero/routes/generated_routes.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _ChatState();
}

class _ChatState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      GeneratedRoute().onGeneratedRoute(
                        const RouteSettings(arguments: '', name: '/chat'),
                      ));
                },
                child: const Row(
                  children: [
                    CircleAvatar(radius: 25, backgroundImage: AssetImage(
                        // 'assets/images/defaults/no_image_user.png')
                        'assets/images/defaults/no_image_user.png')),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "username",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "Message",
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {}, //go to the messages page
                child: Image(
                    height: 22,
                    width: 22,
                    color: Theme.of(context).colorScheme.tertiary,
                    image: const AssetImage("assets/logos/option.png")),
              )
            ],
          ),
        ),
      ],
    )));
  }
}

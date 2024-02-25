import 'package:flutter/material.dart';
import 'package:serophero/routes/generated_routes.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    GeneratedRoute().onGeneratedRoute(
                      const RouteSettings(arguments: '', name: '/view_news'),
                    ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Container for the image
                  Container(
                    height: 120,
                    width: 120,
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/events/event1.png'),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // News title text
                        const Text(
                          "New news is here",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        // Description text for events
                        const Text(
                          'This is new news.. heellloo newssss hii newsssss This is new news.. heellloo newssss hii newssss',
                          style: TextStyle(fontSize: 14),
                          maxLines: 4,
                          softWrap: true,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.only(top: 8),
                            margin: const EdgeInsets.only(right: 8.0),
                            child: const Text(
                              'Datetime',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

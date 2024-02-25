import 'package:flutter/material.dart';
import 'package:serophero/routes/generated_routes.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Row containing image and text
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    GeneratedRoute().onGeneratedRoute(
                      const RouteSettings(arguments: '', name: '/view_events'),
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
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // event title and description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event title text
                        Text(
                          "New event is here",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        // Description text for events
                        const Text(
                          'Bartamanda event is held on 10th Feb.Needed: Tent team, Canteen Location: Sano Thimi, Bhaktapur',
                          style: TextStyle(fontSize: 14),
                          maxLines: 4,
                          softWrap: true,
                        ),
                        // Datetime wdiget
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
            // const Divider()
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:serophero/widgets/news_events_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  GeneratedRoute().onGeneratedRoute(
                    const RouteSettings(arguments: '', name: '/directories'),
                  ));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 35,
              padding: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(21),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search for people",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500),
                  ),
                  const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 23,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  GeneratedRoute().onGeneratedRoute(
                    const RouteSettings(arguments: '', name: '/news_list'),
                  ));
            },
            child: const EventsNewsCard(
              title: "Recent news",
              subtitle: "There has been a flood at .......",
              imagePath: "assets/images/events/events3.png",
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  GeneratedRoute().onGeneratedRoute(
                    const RouteSettings(arguments: '', name: '/events_list'),
                  ));
            },
            child: const EventsNewsCard(
              title: "Upcoming events",
              subtitle: "The Sanepa ground has been holding a festival for ...",
              imagePath: "assets/images/events/event2.png",
            ),
          )
        ],
      ),
    ));
  }
}

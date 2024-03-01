import 'package:flutter/material.dart';
// import 'package:serophero/routes/generated_routes.dart';

class ViewEvent extends StatefulWidget {
  const ViewEvent({super.key});

  @override
  State<ViewEvent> createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Events",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 16.0, left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            const Text("Title for event",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            //image
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/images/events/event1.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //datetime
            Container(
              padding: const EdgeInsets.only(top: 8),
              margin: const EdgeInsets.only(right: 8.0),
              child: const Text(
                'Datetime',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
            const Text(
              "Location: location",
            ),
            //desc
            const Expanded(
                child: Text(
              "something something",
              maxLines: 20,
            )),
            //report
            const SizedBox(height: 10)
          ],
        ),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:serophero/routes/generated_routes.dart';
// import 'package:serophero/routes/generated_routes.dart';

class ViewNews extends StatefulWidget {
  const ViewNews({super.key});

  @override
  State<ViewNews> createState() => _ViewNewsState();
}

class _ViewNewsState extends State<ViewNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "News",
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
            const Text("Title for news",
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
            //desc
            const Expanded(
                child: Text(
              "something something",
              maxLines: 20,
            )),
            //report
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Noticed something wrong?",
                  // style: TextStyle(fontSize: 17)
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        GeneratedRoute().onGeneratedRoute(
                          const RouteSettings(arguments: '', name: '/report'),
                        ));
                  },
                  child: const Text("Report the news",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        // fontSize: 17
                      )),
                )
              ],
            ),
            const SizedBox(height: 10)
          ],
        ),
      )),
    );
  }
}

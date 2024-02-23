import 'package:flutter/material.dart';
import 'package:serophero/routes/generated_routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image(
                    height: 22,
                    width: 22,
                    color: Theme.of(context).colorScheme.tertiary,
                    image: const AssetImage("assets/images/logos/menu.png")),
                SizedBox(width: 20),
                Text(
                  "Hi, Shrasta",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Row(
              children: [
                Image(
                    height: 28,
                    width: 28,
                    color: Theme.of(context).colorScheme.tertiary,
                    image: const AssetImage("assets/images/logos/search.png")),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      GeneratedRoute().onGeneratedRoute(
                        const RouteSettings(
                            arguments: '', name: '/notification'),
                      ),
                    );
                  },
                  child: Image(
                      height: 22,
                      width: 22,
                      color: Theme.of(context).colorScheme.tertiary,
                      image: const AssetImage(
                          "assets/images/logos/notification.png")),
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

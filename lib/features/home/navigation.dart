import 'package:flutter/material.dart';
import 'package:serophero/features/events/event_list.dart';
// import 'package:serophero/features/home/dashboard.dart';
import 'package:serophero/features/home/home.dart';
import 'package:serophero/features/messages/chat_list.dart';
// import 'package:serophero/features/messages/chat_list.dart';
import 'package:serophero/features/news/news_list.dart';
import 'package:serophero/routes/generated_routes.dart';
// import 'package:serophero/features/profile/edit_profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int CurrentTab = 0;
  final List<Widget> screens = [
    const Home(),
    const NewsList(),
    const Event(),
    const Messages(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            GeneratedRoute().onGeneratedRoute(
              const RouteSettings(arguments: '', name: '/add_news'),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageStorage(bucket: bucket, child: currentScreen),
      bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.all(0),
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          color: Colors.transparent,
          elevation: 40,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          notchMargin: 8,
          child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Theme.of(context).colorScheme.primaryContainer),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        splashColor: Colors.transparent,
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = const Home();
                            CurrentTab = 0;
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                height: 25,
                                width: 25,
                                color: Theme.of(context).colorScheme.tertiary,
                                image: CurrentTab == 0
                                    ? const AssetImage(
                                        "assets/images/logos/home_filled.png")
                                    : const AssetImage(
                                        "assets/images/logos/home.png"),
                              ),
                            ]),
                      ),
                      MaterialButton(
                        splashColor: Colors.transparent,
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = const Event();
                            CurrentTab = 1;
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                height: 25,
                                width: 25,
                                color: Theme.of(context).colorScheme.tertiary,
                                image: CurrentTab == 1
                                    ? const AssetImage(
                                        "assets/images/logos/event_filled.png")
                                    : const AssetImage(
                                        "assets/images/logos/event.png"),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        splashColor: Colors.transparent,
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = const NewsList();
                            CurrentTab = 2;
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                height: 25,
                                width: 25,
                                color: Theme.of(context).colorScheme.tertiary,
                                image: CurrentTab == 2
                                    ? const AssetImage(
                                        "assets/images/logos/news_filled.png")
                                    : const AssetImage(
                                        "assets/images/logos/news.png"),
                              ),
                            ]),
                      ),
                      MaterialButton(
                        splashColor: Colors.transparent,
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = const Messages();
                            CurrentTab = 3;
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                height: 25,
                                width: 25,
                                color: Theme.of(context).colorScheme.tertiary,
                                image: CurrentTab == 3
                                    ? const AssetImage(
                                        "assets/images/logos/chat_filled.png")
                                    : const AssetImage(
                                        "assets/images/logos/chat.png"),
                              ),
                            ]),
                      ),
                    ],
                  )
                ],
              ))),
    );
  }
}

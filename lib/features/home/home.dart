import 'package:flutter/material.dart';
import 'package:serophero/features/events/event_list.dart';
import 'package:serophero/features/home/dashboard.dart';
import 'package:serophero/features/messages/chat_list.dart';
import 'package:serophero/features/profile/edit_profile.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int CurrentTab = 0;
  final List<Widget> screens = [
    const Dashboard(),
    const Messages(),
    const EditProfile(),
    const Event(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            Text(
              CurrentTab == 0
                  ? "Welcome Back"
                  : CurrentTab == 1
                      ? "Events"
                      : CurrentTab == 2
                          ? "Messages"
                          : CurrentTab == 3
                              ? "EditProfile"
                              : "",
              style: const TextStyle(fontSize: 18),
            ),
            const Icon(
              Icons.notifications_none,
              color: Colors.black,
            )
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[600],
        onPressed: () {},
        child: const Icon(Icons.add),
        shape: const CircleBorder(eccentricity: 0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(40, 25, 82, 1),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const Dashboard();
                          CurrentTab = 0;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CurrentTab == 0
                                  ? Icons.home
                                  : Icons.home_outlined,
                              color: Colors.white,
                              size: 28,
                            )
                          ]),
                    ),
                    MaterialButton(
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
                            Icon(
                              CurrentTab == 1
                                  ? Icons.event_note
                                  : Icons.event_note_outlined,
                              color: Colors.white,
                              size: 28,
                            )
                          ]),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const Messages();
                          CurrentTab = 2;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CurrentTab == 2
                                  ? Icons.message
                                  : Icons.message_outlined,
                              color: Colors.white,
                              size: 28,
                            )
                          ]),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const EditProfile();
                          CurrentTab = 3;
                        });
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                CurrentTab == 3
                                    ? Icons.person
                                    : Icons.person_2_outlined,
                                color: Colors.white,
                                size: 28)
                          ]),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}

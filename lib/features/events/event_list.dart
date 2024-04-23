import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/events/bloc/event_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';
import 'package:intl/intl.dart';
import 'package:serophero/utils/datetime_utils.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  final EventBloc eventlistbloc = EventBloc();

  @override
  void initState() {
    eventlistbloc.add(EventPageOpened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
        bloc: eventlistbloc,
        builder: (BuildContext context, EventState state) {
          if (state is TokenExpired) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Token is expired'),
                  duration: Duration(seconds: 1),
                ),
              );
            });
          } else if (state is EventListFailure) {
            if (mounted) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    duration: const Duration(seconds: 1),
                  ),
                );
              });
            }
          } else if (state is EventListSuccess) {
            return Scaffold(
              body: SafeArea(
                  child: state.eventlist.isEmpty
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                                    "There are no events that you've been invited to."))
                          ],
                        )
                      : Column(
                          children: state.eventlist.map((event) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        GeneratedRoute().onGeneratedRoute(
                                          RouteSettings(
                                              arguments: {"event": event},
                                              name: '/view_events'),
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Container for the image
                                      Container(
                                        height: 120,
                                        width: 120,
                                        alignment: Alignment.center,
                                        child: Image.network(
                                            "${AppUrls.baseUrl}/${event.eventImage}"),
                                      ),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Event title text
                                            Text(
                                              event.eventTitle,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            // Description text for events
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.45,
                                              child: Column(
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    event.eventDescription,
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    softWrap: true,
                                                  ),
                                                  Text(
                                                    "Event location: ${event.eventLocation}",
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    // softWrap: true,
                                                  ),
                                                  Text(
                                                    "Event date: ${DateFormat('yyyy-MM-dd').format(event.eventDate)}",
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Datetime wdiget
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                margin: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                  DateTimeUtils
                                                      .formatRelativeTime(
                                                          event.postedDate),
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          }).toList(),
                        )),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });

    // Scaffold(
    //   body: SafeArea(
    //     child: Column(
    //       children: [
    //         // Row containing image and text
    //         GestureDetector(
    //           onTap: () {
    //             Navigator.push(
    //                 context,
    //                 GeneratedRoute().onGeneratedRoute(
    //                   const RouteSettings(arguments: '', name: '/view_events'),
    //                 ));
    //           },
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               // Container for the image
    //               Container(
    //                 height: 120,
    //                 width: 120,
    //                 alignment: Alignment.center,
    //                 child: Image.asset('assets/images/events/event1.png'),
    //               ),
    //               // const SizedBox(
    //               //   width: 5,
    //               // ),
    //               // event title and description
    //               Expanded(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     // Event title text
    //                     Text(
    //                       "New event is here",
    //                       style: TextStyle(
    //                           fontSize: 18, fontWeight: FontWeight.normal),
    //                     ),
    //                     // Description text for events
    //                     const Text(
    //                       'Bartamanda event is held on 10th Feb.Needed: Tent team, Canteen Location: Sano Thimi, Bhaktapur',
    //                       style: TextStyle(fontSize: 14),
    //                       maxLines: 4,
    //                       softWrap: true,
    //                     ),
    //                     // Datetime wdiget
    //                     Align(
    //                       alignment: Alignment.bottomRight,
    //                       child: Container(
    //                         padding: const EdgeInsets.only(top: 8),
    //                         margin: const EdgeInsets.only(right: 8.0),
    //                         child: const Text(
    //                           'Datetime',
    //                           style:
    //                               TextStyle(fontSize: 13, color: Colors.grey),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         // const Divider()
    //       ],
    //     ),
    //   ),
    // );
  }
}

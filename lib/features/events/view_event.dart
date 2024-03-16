import 'package:flutter/material.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/events/data/event_model.dart';
import 'package:serophero/utils/datetime_utils.dart';
// import 'package:serophero/routes/generated_routes.dart';

class ViewEvent extends StatefulWidget {
  final EventListModel event;
  const ViewEvent({super.key, required this.event});

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
            Text(widget.event.eventTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            //image
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      "${AppUrls.baseUrl}/${widget.event.eventImage}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //datetime
            Container(
              padding: const EdgeInsets.only(top: 8),
              margin: const EdgeInsets.only(right: 8.0),
              child: Text(
                'by ${widget.event.postedBy}, ${DateTimeUtils.formatRelativeTime(widget.event.postedDate)}',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
            Text(
              "Location: ${widget.event.eventLocation}",
            ),
            Text(
              "EventDate: ${DateTimeUtils.formatRelativeTime(widget.event.eventDate)}",
            ),
            //desc
            Expanded(
                child: Text(
              widget.event.eventDescription,
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

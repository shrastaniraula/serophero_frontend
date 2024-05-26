import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:serophero/features/notifications/bloc/notification_bloc.dart';
import 'package:serophero/utils/datetime_utils.dart';
import 'package:serophero/widgets/custom_elevated_button.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("View Notifications"))),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<NotificationBloc>().add(NotificationPageOpened());
            // return;
          },
          child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
            if (state is NotificationSuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Column(
                    children: state.notificationlist.map((notification) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Container for the image
                              const CircleAvatar(
                                  radius: 28,
                                  backgroundImage: AssetImage(
                                      'assets/images/defaults/notification.png')),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notification.title.toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.45,
                                      child: Row(
                                        children: [
                                          Column(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                notification.message!,
                                                style: const TextStyle(
                                                    fontSize: 14),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                softWrap: true,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Datetime wdiget
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 8),
                                        margin:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          DateTimeUtils.formatRelativeTime(
                                              notification.notificationTime!),
                                          style: const TextStyle(
                                              fontSize: 13, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            }
            if (state is NotificationFailure) {
              return const Text("Failure");
            }
            context.read<NotificationBloc>().add(NotificationPageOpened());
            return CustomElevatedButton(
              text: "Retry",
              onPressed: () {
                context.read<NotificationBloc>().add(NotificationPageOpened());
              },
            );
          }),
        ),
      ),
    );
  }
}

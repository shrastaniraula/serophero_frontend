import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/constants/app_urls.dart';
import 'package:serophero/features/chat/bloc/chat_list_bloc.dart';
import 'package:serophero/routes/generated_routes.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _ChatState();
}

class _ChatState extends State<Messages> {
  final ChatListBloc chatlistbloc = ChatListBloc();

  @override
  void initState() {
    chatlistbloc.add(ChatPageOPened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: BlocBuilder<ChatListBloc, ChatListState>(
            bloc: chatlistbloc,
            builder: (BuildContext context, ChatListState state) {
              if (state is TokenExpired) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Token is Expired'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                });
              } else if (state is ChatListFailure) {
                if (mounted) {
                  // Show SnackBar using ScaffoldMessenger outside the build method
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  });
                }
              } else if (state is ChatListSuccess) {
                return Column(
                  children: state.chatlist.map((chat) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print(chat.userId);
                                print(chat.myId);
                                Navigator.push(
                                    context,
                                    GeneratedRoute().onGeneratedRoute(
                                      RouteSettings(arguments: {
                                        "myId": chat.myId,
                                        "userId": chat.userId
                                      }, name: '/chat_page'),
                                    ));
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 25,
                                      backgroundImage: chat.userImage != ""
                                          ? NetworkImage(
                                              '${AppUrls.baseUrl}/media/${chat.userImage}')
                                          : const AssetImage(
                                                  'assets/images/defaults/no_image_user.png')
                                              as ImageProvider<Object>),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        chat.userFullName,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        chat.message,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     GeneratedRoute().onGeneratedRoute(
                                //       const RouteSettings(
                                //           arguments: '', name: '/chat_page'),
                                //     ));
                              },
                              child: Image(
                                height: 22,
                                width: 22,
                                color: Theme.of(context).colorScheme.tertiary,
                                image:
                                    const AssetImage("assets/logos/option.png"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    )));
  }
}

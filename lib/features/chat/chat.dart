import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/chat/bloc/individual_chat_bloc/individual_chat_bloc.dart';
import 'package:serophero/utils/shared_preferences.dart';
import 'package:serophero/widgets/custom_textfield.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Message {
  final String text;
  final bool isMe;

  Message(this.text, this.isMe);
}

class ChatScreen extends StatefulWidget {
  final int userId;
  // final int myId;

  const ChatScreen({super.key, required this.userId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebSocketChannel channel;
  int myId = 0;

  final TextEditingController _textController = TextEditingController();
  List<Message> messages = [];

  late IndividualChatBloc _chatBloc;

  void getIdAsync() async {
    String id = await SharedUtils.getId();
    setState(() {
      myId = int.parse(id);
    });
  }

  @override
  void initState() {
    super.initState();
    getIdAsync();

    _chatBloc = IndividualChatBloc();
    _chatBloc.add(IndividualChatOpened(userId: '${widget.userId}'));

    channel = IOWebSocketChannel.connect(
        'ws://192.168.1.68:8000/ws/chat/$myId/${widget.userId}/');

    // Handle incoming messages
    channel.stream.listen((message) {
      var newMessage = jsonDecode(message);

      bool isMe = newMessage['username_from'] == myId;

      setState(() {
        messages.add(Message(newMessage['message'], isMe));
      });
    });
  }

  void _sendMessage() {
    String message = _textController.text.trim();
    print(message);
    print(myId);
    print(widget.userId);
    if (message.isEmpty) return;

    channel.sink
        .add('{"message": "$message", "from": $myId, "to": ${widget.userId} }');
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: BlocProvider(
        create: (_) => _chatBloc,
        child: BlocBuilder<IndividualChatBloc, IndividualChatState>(
          builder: (context, state) {
            if (state is IndividualChatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is IndividualChatFailure) {
              return Center(child: Text(state.error));
            } else if (state is IndividualChatSuccess) {
              final allMessages = [
                ...state.chatlist
                    .map((chat) => Message(chat.message, chat.sentByMe)),
                ...messages,
              ];

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: allMessages.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: allMessages[index].isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: allMessages[index].isMe
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                    : Colors.blueGrey,
                              ),
                              child: Text(allMessages[index].text)),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: _textController,
                            hintText: 'Type your message...',
                            context: context,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _sendMessage,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No chat history available.'));
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}

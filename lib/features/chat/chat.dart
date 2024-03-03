import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final channel = IOWebSocketChannel.connect('ws://192.168.1.65:8000/ws/chat/');
  final TextEditingController _textController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();

    // Handle incoming messages
    channel.stream.listen((message) {
      print('Received: $message');
      // Add logic to update the UI or handle the message
      setState(() {
        messages.add(message);
      });
    });

    // Send a welcome message when the widget initializes
    channel.sink.add('{"message": "Hello, server!"}');
  }

  void _sendMessage() {
    String message = _textController.text.trim();
    if (message.isNotEmpty) {
      channel.sink.add('{"message": "$message"}');
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Close the WebSocket connection when the widget is disposed
    channel.sink.close();
    super.dispose();
  }
}

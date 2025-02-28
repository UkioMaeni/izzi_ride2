import 'package:flutter/material.dart';
import 'package:izzi_ride_2/pages/chat_page/components/chat_info.dart';
import 'package:izzi_ride_2/pages/chat_page/components/chat_ride_info.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          ChatInfo(),
          ChatRideInfo()
        ],
      ),
    );
  }
}
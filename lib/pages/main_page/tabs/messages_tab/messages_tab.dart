import 'package:flutter/material.dart';
import 'package:izzi_ride_2/UI/tab_header.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/messages_tab/components/message_item.dart';

class MessagesTab extends StatefulWidget {
  const MessagesTab({super.key});

  @override
  State<MessagesTab> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: UITabHeader(label: "Messages"),
          ),
          SizedBox(height: 64,),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return MessageItemView();
              },
            ),
          )
        ],
      ),
    );
  }
}
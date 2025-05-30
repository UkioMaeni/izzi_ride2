import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/UI/tab_header.dart';
import 'package:izzi_ride_2/core/bloc/chats_bloc/chats_bloc.dart';
import 'package:izzi_ride_2/core/providers/chat_provider.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/messages_tab/components/message_item.dart';
import 'package:provider/provider.dart';

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
            child: Consumer<ChatSProvider>(
              builder: (context, chats, child) {
                bool firstLoading=chats.firstLoading;
                if(!firstLoading){
                  chatProvider.getChats();
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                 }
                  if(chats.chats.length==0){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 71),
                      child: R.Image.IllustrtationMessages,
                    );
                  }
                  return ListView.builder(
                    itemCount: chats.chats.length,
                    itemBuilder: (context, index) {
                      return MessageItemView(chat:chats.chats[index]);
                    },
                  );
              },
              
            ),
          )
        ],
      ),
    );
  }
}
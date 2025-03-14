import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/bloc/chats_bloc/chats_bloc.dart';
import 'package:izzi_ride_2/core/bloc/user_me_bloc/user_me_bloc.dart';
import 'package:izzi_ride_2/core/models/chat_model.dart';
import 'package:izzi_ride_2/core/models/message_model.dart';
import 'package:izzi_ride_2/core/providers/chat_provider.dart';
import 'package:izzi_ride_2/core/socket/app_socket.dart';
import 'package:izzi_ride_2/pages/chat_page/components/chat_info.dart';
import 'package:izzi_ride_2/pages/chat_page/components/chat_ride_info.dart';
import 'package:izzi_ride_2/pages/chat_page/components/input_area.dart';
import 'package:izzi_ride_2/pages/chat_page/components/messages_area.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  Uuid uuid=const  Uuid();
      
  void sendMessage(String textMessage){
    final senderClientId= context.read<UserMeBloc>().state.me!.clienId;
    final chatId=chatProvider.currentChatId;
    Message message = TextMessage(
      id: -1, 
      clientId: senderClientId, 
      status: -1, 
      frontContentId: uuid.v4(),
       messageTime: DateTime.now(), 
       chatId: chatId, 
       content: textMessage
      );
    chatProvider.sendMessage(message);
    print("SEND");
  }

  fullRead(int chatId){
    appSocket.fullReadMessage(chatId);
  }


  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Consumer<ChatSProvider>(
        builder: (context,chats,_) {
          Chat chat;
          int currentChatId = chats.currentChatId;
          if(currentChatId==-1){
            chat=Chat.nullable();
          }else{
            chat= chats.chats.firstWhere((element) => element.chatId==currentChatId,orElse: () => Chat.nullable(),);
            fullRead(chat.chatId);
          }
          if(chat.chatId==-1&&chatProvider.currentChatId!=-1){
            chatProvider.getChat();
          }
          return Column(
            children: [
              ChatInfo(
                chat: chat,
              ),
              ChatRideInfo(
                chat: chat,
              ),
              Expanded(
                child: MessagesArea()
              ),
              Builder(
                builder: (context) {
                  final chatBloc= context.watch<ChatsBloc>();
                  log(chatBloc.isClosed.toString());
                  return InputArea(
                    sendMessage: sendMessage,
                  );
                }
              ),
              SizedBox(height: 16,)
            ],
          );
        }
      ),
    );
  }
}
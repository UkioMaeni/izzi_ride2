import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/bloc/chats_bloc/chats_bloc.dart';
import 'package:izzi_ride_2/core/bloc/user_me_bloc/user_me_bloc.dart';
import 'package:izzi_ride_2/core/models/chat_model.dart';
import 'package:izzi_ride_2/core/models/message_model.dart';
import 'package:izzi_ride_2/core/providers/chat_provider.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:provider/provider.dart';

class MessagesArea extends StatefulWidget {
  const MessagesArea({super.key});

  @override
  State<MessagesArea> createState() => _MessagesAreaState();
}

class _MessagesAreaState extends State<MessagesArea> {
  ScrollController _controller =ScrollController();
  @override
  Widget build(BuildContext context) {
    final me= context.read<UserMeBloc>().state.me!;
    
  
    return Consumer<ChatSProvider>(
      builder: (context,chats, child) {
        int currentChatId = chats.currentChatId;
        Chat chat= chats.chats.firstWhere((element) => element.chatId==currentChatId,orElse: () => Chat.nullable(),);
        if(chat.chatId==-1){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Message> messages=chat.messages;
        log(chats.chats.length.toString());
        return ListView.builder(
          reverse: true,
          controller: _controller,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            bool myMessage=messages[index].clientId==me.clienId;
            return Container(
                width: double.infinity,
                alignment: myMessage?Alignment.centerRight:Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.only(bottom: 16),
                child: Stack(
                  
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minHeight: 37,
                        minWidth: 230,
                      ),
                      decoration: BoxDecoration(
                        color: myMessage?BrandColor.blue:BrandColor.verylightBlue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: myMessage? Radius.circular(12):Radius.circular(0),
                          bottomRight: !myMessage? Radius.circular(12):Radius.circular(0)
                        )
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                                (messages[index] as TextMessage).content,
                                style: TextStyle(
                                  fontFamily: BrandFontFamily.platform,
                                  fontSize: 16,
                                  color:myMessage?Colors.white:BrandColor.black69,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                    ),
                    Positioned(
                      bottom: 10.5,
                      right: 13.75,
                      child: Builder(
                        builder: (context) {
                          if(myMessage){
                            return Row(
                              children: [
                                Text(
                                  "20:19",
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                                SizedBox(width: 4,),
                                Builder(
                                  builder: (context) {
                                    if(messages[index].status==-1){
                                      return R.SVG.MessageStatusWait;
                                    }
                                    if(messages[index].status==0){
                                      return R.SVG.MessageStatusSend;
                                    }
                                    return R.SVG.MessageStatusRead;
                                  }
                                ),
                              ],
                            );
                          }else{
                            return Text(
                                "20:19",
                                style: TextStyle(
                                  fontFamily: BrandFontFamily.platform,
                                  fontSize: 16,
                                  color:myMessage? Colors.white:BrandColor.blue,
                                  fontWeight: FontWeight.w400
                                ),
                              );
                          }
                          
                        }
                      )
                    )
                  ],
                ),
                
              );
          },
        );
      }
    );
  }
}
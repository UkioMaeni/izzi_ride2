import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/chats_bloc/chats_bloc.dart';
import 'package:izzi_ride_2/core/models/chat_model.dart';
import 'package:izzi_ride_2/core/models/message_model.dart';
import 'package:izzi_ride_2/core/providers/chat_provider.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class MessageItemView extends StatelessWidget {
  final Chat chat;
  const MessageItemView({super.key,required this.chat});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        chatProvider.setCurrentChat(chat.chatId);
        context.pushNamed(RoutesName.chat);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
          height: 71,
          child: Column(
            children: [
              Container(
                height: 64,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 24,),
                    avatar(),
                    SizedBox(width: 8,),
                    chatInfo(),
                    Expanded(child: SizedBox.shrink()),
                    messageInfo(),
                    SizedBox(width: 24,)
                  ],
                ),
              ),
              SizedBox(height: 6,),
              Container(
                margin: EdgeInsets.only(left: 109),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: BrandColor.grey227
                    )
                  )
                ),
              )
            ],
          ),
        
      ),
    );
  }

  Widget avatar(){
    print(chat.members[0].photo);
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: SizedBox(
        width: 64,
        height: 64,
        child: Image.network(
          //chat.members[0].photo,
          "https://cs10.pikabu.ru/post_img/big/2018/02/20/10/1519147784145166438.jpg",
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
                  return child;
            }
            return Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: BrandColor.grey,
                border: Border.all(
                  color: BrandColor.black
                ),
                borderRadius: BorderRadius.circular(32)
              ),
              alignment: Alignment.center,
              child: Text(
                chat.members[0].clientName[0],
                style: TextStyle(
                  fontFamily: BrandFontFamily.platform,
                  fontSize: 25,
                  color: BrandColor.grey167,
                  fontWeight: FontWeight.w400
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  
  Widget messageInfo(){
    return Row(
      children: [
        R.SVG.MessageStatusRead,
        SizedBox(width: 8,),
        Builder(
          builder: (context) {
            String date= DateFormat("hh:mm a").format(DateTime.now());
            return Text(
              date,
              style: TextStyle(
                fontFamily: BrandFontFamily.platform,
                fontSize: 12,
                color: BrandColor.grey167,
                fontWeight: FontWeight.w400
              ),
            );
          }
        ),
      ],
    );
  }

  Widget chatInfo(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
                chat.members[0].clientName,
                style: TextStyle(
                  fontFamily: BrandFontFamily.platform,
                  fontSize: 18,
                  color: BrandColor.black,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(width: 32,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3.5),
                decoration: BoxDecoration(
                  color: BrandColor.blue,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  children: [
                    Text(
                      chat.startLocation,
                      style: TextStyle(
                        fontFamily: BrandFontFamily.platform,
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(width: 8,),
                    Icon(Icons.arrow_forward,size: 18,color: Colors.white,),
                    SizedBox(width: 8,),
                    Text(
                      chat.endLocation,
                      style: TextStyle(
                        fontFamily: BrandFontFamily.platform,
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
        SizedBox(height: 8,),
        Builder(
          builder: (context) {
            String message='';
            print(chat.messages);
            if(chat.messages.isNotEmpty){
              final message=chat.messages[0];
              
              if(message is TextMessage){
                
                return Text(
                  message.content,
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 16,
                    color: BrandColor.grey167,
                    fontWeight: FontWeight.w400
                  ),
                );
              }
            }
            return SizedBox.shrink();
          }
        ),
      ],
    );
  }
}
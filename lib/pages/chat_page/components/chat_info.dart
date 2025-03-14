import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/chat_model.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class ChatInfo extends StatelessWidget {
  final Chat chat;
  const ChatInfo({super.key,required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 15),
              width: 63,
              child: R.SVG.NavigationBackIcon,
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if(chat.chatId==-1){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Row(
                  children: [
                    avatar(),
                    SizedBox(width: 8,),
                    chatInfo(),
                  ],
                );
              }
            ),
          )
        ],
      ),
    );
  }
  Widget chatInfo(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
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
        SizedBox(height: 8,),
        Text(
          chat.members[0].status,
          style: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 16,
            color: BrandColor.blue,
            fontWeight: FontWeight.w400
          ),
        ),
      ]
    );
  }
  Widget avatar(){
    //print(chat.members[0].photo);
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
}
import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class ChatInfo extends StatelessWidget {
  const ChatInfo({super.key});

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
          avatar(),
          SizedBox(width: 8,),
          chatInfo()
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
          "MIKE D",
          style: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 18,
            color: BrandColor.black,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 8,),
        Text(
          "Online",
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
    return Container(
      width: 64,
      height: 64,
      
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(32)
      ),
    );
  }
}
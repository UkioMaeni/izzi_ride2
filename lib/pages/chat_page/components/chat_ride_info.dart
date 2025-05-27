import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/chat_model.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class ChatRideInfo extends StatelessWidget {
  final Chat chat;
  const ChatRideInfo({super.key,required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: BrandColor.grey244
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Builder(
                    builder: (context) {
                      String date = DateFormat("MMM dd").format(DateTime.now());
                      date="_date_";
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
                  Text(
                    "_time_",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 20,
                      color: BrandColor.black69,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    chat.startLocation,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 16,
                      color: BrandColor.grey167,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "_!_21h31min (1 456,3 m.)",
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 12,
                    color: BrandColor.grey167,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 8,),
                Transform.scale(
                  scale: 1.2,
                  child: R.SVG.MessageDottedLine
                )
              ],
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    chat.endLocation,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 16,
                      color: BrandColor.grey167,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            )
            
          ],
        ),
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
            color: BrandColor.black69,
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
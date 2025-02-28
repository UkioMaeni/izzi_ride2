import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class MessageItemView extends StatelessWidget {
  const MessageItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        context.pushNamed(RoutesName.chat);
      },
      child: SizedBox(
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
    return Container(
      width: 64,
      height: 64,
      
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(32)
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
                "MIKE D",
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
                      "NEV",
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
                      "SF",
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
        Text(
          "Hello, where have you gone?",
          style: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 16,
            color: BrandColor.grey167,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }
}
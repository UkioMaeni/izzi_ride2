import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/travaler_model.dart';
import 'package:izzi_ride_2/core/tools/color_generator.dart';
import 'package:izzi_ride_2/pages/actions_ride_page/actions_ride_provider/actions_ride_provider.dart';
import 'package:provider/provider.dart';

class ActionsRidePageDone extends StatefulWidget {
  const ActionsRidePageDone({super.key});

  @override
  State<ActionsRidePageDone> createState() => _ActionsRidePageDoneState();
}

class _ActionsRidePageDoneState extends State<ActionsRidePageDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: BrandColor.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: BrandColor.white,
      ),
      body: Consumer<ActionsRideProvider>(
        builder: (context, action, child) {
          log(action.newTravalers.toString());
          if(action.newTravalers.isEmpty){
            return Text("Oops");
          }
          final currentTravalers = action.newTravalers[0];
          String currentTravalersNickname="";
          if(currentTravalers.nickname.isEmpty){
            currentTravalersNickname="!";
          }else{
            currentTravalersNickname=currentTravalers.nickname;
          }
          return Column(
            children: [
              Text(
                "Approve The\nPassenger's Booking",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 32,
                  color:BrandColor.black,
                  fontWeight: FontWeight.w700
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    currentTravalers.avatarUrl,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: ColorGenerator.fromString(currentTravalersNickname),
                        child: Text(
                          currentTravalersNickname[0],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "SF",
                            fontSize: 32,
                            color:BrandColor.black,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Text(
                currentTravalersNickname,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 20,
                  color:BrandColor.black,
                  fontWeight: FontWeight.w700
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
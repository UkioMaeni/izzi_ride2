import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/instant_booking_scene/components/congratiation.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/instant_booking_scene/components/initial_page.dart';

class InstantBookingScene extends StatefulWidget {
  const InstantBookingScene({super.key});

  @override
  State<InstantBookingScene> createState() => _InstantBookingSceneState();
}

class _InstantBookingSceneState extends State<InstantBookingScene> {

  String page="initial";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          NavBar(),
          Expanded(child: SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Builder(
              builder: (context) {
                if(page=="initial"){
                  return InitialPageInstant(toCongratiation: () {
                    setState(() {
                      page="congratiation";
                    });
                  },);
                }else{
                 return CongratiationInstant();
                }
                
              }
            )
          ),
        ],
      ),
    );
  }
}
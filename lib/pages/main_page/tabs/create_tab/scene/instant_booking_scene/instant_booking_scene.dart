import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:izzi_ride_2/UI/button.dart';

class InstantBookingScene extends StatefulWidget {
  const InstantBookingScene({super.key});

  @override
  State<InstantBookingScene> createState() => _InstantBookingSceneState();
}

class _InstantBookingSceneState extends State<InstantBookingScene> {
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
          UIButton(
            reverse: true,
            label: "View each request"
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class AdditionalOptionsScene extends StatefulWidget {
  const AdditionalOptionsScene({super.key});

  @override
  State<AdditionalOptionsScene> createState() => _AdditionalOptionsSceneState();
}

class _AdditionalOptionsSceneState extends State<AdditionalOptionsScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 36),
                height: 50,
                alignment: Alignment.centerLeft,
                child: R.SVG.NavigationBackIcon,
              ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
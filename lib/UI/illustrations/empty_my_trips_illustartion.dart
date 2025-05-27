import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class EmptyMyTripsIllustartion extends StatelessWidget {
  const EmptyMyTripsIllustartion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        R.Image.IllustrtationMap,
        SizedBox(height: 50,),
        Text(
          "Your upcoming trips will be\ndisplaye here",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 20,
            color: BrandColor.black69,
            fontWeight: FontWeight.w800
          ),
        )
      ],
    );
  }
}
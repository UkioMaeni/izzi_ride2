import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/trip.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  const TripCard({super.key,required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 322,
      decoration: BoxDecoration(
        border: Border.all(
          color: BrandColor.grey167,
        ),
        borderRadius: BorderRadius.circular(17)
      ),
      child: Row(
        children: [
          date(),
          indicator()
        ],
      ),
    );
  }

  Widget indicator(){
    return Container(
      height: 195,
      width: 40,
      decoration: BoxDecoration(
        color: BrandColor.blue,
        borderRadius: BorderRadius.circular(57)
      ),
    );
  }

  Widget date(){
    return Column(
      children: [
        Text(
          "03 May",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "SF",
            fontSize: 12,
            color:BrandColor.black,
            fontWeight: FontWeight.w400
          ),
        ), 
        Text(
          "03:00",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "SF",
            fontSize: 20,
            color:BrandColor.black,
            fontWeight: FontWeight.w700
          ),
        ), 
      ],
    );
  }
}
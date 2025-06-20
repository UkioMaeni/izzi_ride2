import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';

class FullOrderPrice extends StatelessWidget {
  final RideModel trip;
  final int? currentNumberOfSeats;
  const FullOrderPrice({super.key,required this.trip,this.currentNumberOfSeats});

  @override
  Widget build(BuildContext context) {
    log(trip.price.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //             "Price",
          //             style: TextStyle(
          //               fontFamily: BrandFontFamily.platform,
          //               fontSize: 26,
          //               color: BrandColor.black,
          //               fontWeight: FontWeight.w800
          //             ),
          //           ),
          Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "One traveler",
                      style: TextStyle(
                        fontFamily: BrandFontFamily.platform,
                        fontSize: 20,
                        color: BrandColor.black69,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    Text(
                      "\$"+trip.price.toString(),
                      style: TextStyle(
                        fontFamily: BrandFontFamily.platform,
                        fontSize: 30,
                        color: BrandColor.black69,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  
                  children: [
                    Text(
                      "Total price ",
                      style: TextStyle(
                        fontFamily: BrandFontFamily.platform,
                        fontSize: 16,
                        color: BrandColor.black69,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      (trip.clientNumberOfSeats??1).toString(),
                      style: TextStyle(
                        fontFamily: BrandFontFamily.platform,
                        fontSize: 18,
                        color: BrandColor.blue,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      "x",
                      style: TextStyle(
                        fontFamily: BrandFontFamily.platform,
                        fontSize: 18,
                        color: BrandColor.blue,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      "\$"+(trip.price).toString(),
                      style: TextStyle(
                        fontFamily: BrandFontFamily.platform,
                        fontSize: 18,
                        color: BrandColor.blue,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    Expanded(child: SizedBox.shrink()),
                    Text(
                      "\$"+(trip.price*(trip.clientNumberOfSeats??1)).toString(),
                      style: TextStyle(
                        fontFamily: BrandFontFamily.platform,
                        fontSize: 26,
                        color: BrandColor.black69,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                  ],
                ),

        ],
      ),
    );
  }
}
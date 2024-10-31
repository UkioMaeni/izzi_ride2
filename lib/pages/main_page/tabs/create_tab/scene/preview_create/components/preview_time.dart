import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class PreviewTime extends StatelessWidget {
  const PreviewTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: 235
          ),
          padding: EdgeInsets.only(
            left: 32,
            top: 55.5,
            right: 82
          ),
          decoration: BoxDecoration(
            color: BrandColor.grey244,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 12,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "03 May 2024",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 12,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 12,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "05:00AM",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 12,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 37,),
                  Text(
                    "Seats",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 12,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "4",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 12,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: -0.5,
          right: 12,
          left: 12,
          child: R.SVG.DottedLine,
        ),
      ],
    );
  }
}
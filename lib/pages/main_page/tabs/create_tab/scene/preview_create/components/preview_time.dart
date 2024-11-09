import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/bloc/car_bloc/car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class PreviewTime extends StatelessWidget {
  const PreviewTime({super.key});

  @override
  Widget build(BuildContext context) {
    final createRideBlocState = context.read<CreateRideBloc>().state;

    String date = DateFormat("dd MMMM yyyy").format(createRideBlocState.date);
    String time = DateFormat("h:mm a").format(DateTime(0,0,0,createRideBlocState.time.hour,createRideBlocState.time.minute));
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
                    date,
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
                    time,
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
                    createRideBlocState.car.seats.toString(),
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
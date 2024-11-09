import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/core/tools/color_generator.dart';

class PreviewData extends StatelessWidget {
  const PreviewData({super.key});


  

  @override
  Widget build(BuildContext context) {
    final createBlocState = context.read<CreateRideBloc>().state;
    print(createBlocState.car.color);
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 22,
            left: 32,
            right: 0
          ),
          decoration: BoxDecoration(
            color: BrandColor.grey244,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            children: [
              
              header(createBlocState.car.color,createBlocState.car.brand+" "+createBlocState.car.model),
              SizedBox(height: 20.5,),
              body(createBlocState.price),
              SizedBox(height: 31.5,),
              footer(),
              SizedBox(height: 34,),
            ],
          ),
        ),
        Positioned(
          top: -0.5,
          right: 12,
          left: 12,
          child: R.SVG.DottedLine,
        ),
        Positioned(
          bottom: -0.5,
          right: 12,
          left: 12,
          child: R.SVG.DottedLine,
        )
      ],
    );
  }

  Widget footer(){
    return Row(
      children: [
        Text(
          "Travel Preferences",
          style: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 12,
            color: BrandColor.black,
            fontWeight: FontWeight.w400
          ),
        ),
        Row(
          children: [

            SizedBox(width: 44.5,)
          ],
        )
      ],
    );
  }


  Widget body(int price){
    return Padding(
      padding: const EdgeInsets.only(right: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 84,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment",
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 12,
                    color: BrandColor.black,
                    fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  "Cash",
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 18,
                    color: BrandColor.black,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 84,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Service fee",
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 12,
                    color: BrandColor.black,
                    fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  "\$0",
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 18,
                    color: BrandColor.black,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 84,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fare",
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 12,
                    color: BrandColor.black,
                    fontWeight: FontWeight.w400
                  ),
                ),
                Text(
                  "\$"+price.toString(),
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 18,
                    color: BrandColor.black,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget header(String color,String car){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  avatar("","Alex"),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "⭐ 5.0",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 12,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    "James S.",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 18,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            ],
          ), 
          SizedBox(width: 8,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                color,
                style: TextStyle(
                  fontFamily: BrandFontFamily.platform,
                  fontSize: 12,
                  color: BrandColor.black,
                  fontWeight: FontWeight.w400
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 23,
                  maxWidth: 140
                ),
                child: Text(
                  car,
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 18,
                    color: BrandColor.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: 5,),
        ],
      );
  }

  Widget avatar(String photoUrl,String errorString){
    return ClipRRect(
      borderRadius: BorderRadius.circular(23),
      child: Container(
        width: 46,
        height: 46,
        color: ColorGenerator.fromString(errorString),
        alignment: Alignment.center,
        child: Image.network(
          photoUrl,
          errorBuilder: (context, error, stackTrace) {
            return Text(
              errorString[0],
              style: TextStyle(
                fontFamily: BrandFontFamily.platform,
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w400
              ),
            );
          },
        ),
      )
    );
  }

}
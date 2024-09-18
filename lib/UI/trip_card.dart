import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/trip.dart';
import 'package:izzi_ride_2/core/tools/color_generator.dart';
import 'package:shimmer/shimmer.dart';

class TripCard extends StatelessWidget {

  static TripCard shimmer(){
    return TripCard(trip: Trip.nullable(), isShimmer: true);
  }
  static TripCard view({required Trip trip}){
    return TripCard(trip: trip, isShimmer: false);
  }
  final Trip trip;
  final bool isShimmer;
  const TripCard ({super.key,required this.trip,required this.isShimmer});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 322,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: BrandColor.grey167,
        ),
        borderRadius: BorderRadius.circular(17)
      ),
      child: Shimmer.fromColors(
             enabled: true,

            baseColor: BrandColor.grey217,
            highlightColor: BrandColor.grey167,
          
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                date(),
                SizedBox(width: 12,),
                indicator(),
                SizedBox(width: 16,),
                Expanded(child: locations()),
                info()
              ],
            ),
            SizedBox(height: 24,),
            Container(
              alignment: Alignment.center,
              color: BrandColor.grey167,
              height: 1,
              margin: EdgeInsets.only(left:28 ),
            ),
            SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    avatar(),
                    SizedBox(width: 12,),
                    driver(),
                  ],
                ),
                passangersAvatar()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget passangersAvatar(){
    return SizedBox(
      height: 44,
      width: 44+2*22,
      child: Stack(
        children: [
          Positioned(
            right: 44,
            child: avatar()
          ),
          Positioned(
            right: 22,
            child: avatar()
          ),
          Positioned(
            right: 0,
            child: avatar()
          )
        ],
      ),
    );
  }

  Widget driver(){
    if(isShimmer){
      return SizedBox(
        height: 44,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 23,
              alignment: Alignment.center,
              
              decoration: BoxDecoration(
                color: BrandColor.grey167,
              ),
             ),
             Container(
              width: 120,
              height: 16,
              alignment: Alignment.center,
              
              decoration: BoxDecoration(
                color: BrandColor.grey167,
              ),
             ),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Mike D",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: "SF",
                fontSize: 18,
                color:BrandColor.black,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(width: 8,),
            Text(
              "⭐ 5.0",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: "SF",
                fontSize: 18,
                color:BrandColor.black,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        Text(
          "BMW 3 Series",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "SF",
            fontSize: 12,
            color:BrandColor.grey167,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }

  Widget avatar(){
    // if(isShimmer){
    //   return Shimmer.fromColors(
    //        child: Container(
    //         width: 44,
    //         height: 44,
    //         alignment: Alignment.center,
            
    //         decoration: BoxDecoration(
    //           color: BrandColor.grey167,
    //           borderRadius: BorderRadius.circular(22)
    //         ),
    //        ),
    //        enabled: true,
    //       baseColor: BrandColor.grey217,
    //       highlightColor: BrandColor.grey167,
    //     );
    // }
    if(false ){
      return Image.network("");
    }else{
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          
          border: Border.all(color: Colors.white),
          color: ColorGenerator.fromString("Mike D"),
          borderRadius: BorderRadius.circular(22)
        ),
        alignment: Alignment.center,
        child: Text(
          "M",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "SF",
            fontSize: 20,
            color:Colors.white,
            fontWeight: FontWeight.w400
          ),
        ),
      );
    }
  }

  Widget info(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !isShimmer?Text(
          "For a place",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "SF",
            fontSize: 12,
            color:BrandColor.black,
            fontWeight: FontWeight.w400
          ),
        ):Container(
          width: 50,
          height: 17,
          color: BrandColor.grey167,
        ), 
        SizedBox(height: 8,),
        !isShimmer?Text(
          "\$25",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "SF",
            fontSize: 20,
            color:BrandColor.black,
            fontWeight: FontWeight.w700
          )
        ):Container(
          width: 30,
          height: 29,
          color: BrandColor.grey167,
        ), 
        SizedBox(height: 8,),
        SizedBox(
          height: 1,
          width: 75,
          child: ColoredBox(color: BrandColor.grey227),
        ),
        SizedBox(height: 10,),
         !isShimmer?Text(
          "3 of 4",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "SF",
            fontSize: 18,
            color:BrandColor.black,
            fontWeight: FontWeight.w500
          ),
        ):Container(
          width: 40,
          height: 26,
          color: BrandColor.grey167,
        ), 
        SizedBox(height: 4,),
         !isShimmer?Text(
          "are free",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "SF",
            fontSize: 12,
            color:BrandColor.grey167,
            fontWeight: FontWeight.w400
          ),
        ):Container(
          width: 35,
          height: 19,
          color: BrandColor.grey167,
        ),  
      ],
    );
  }

  Widget locations(){
    return SizedBox(
      height: 195,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               isShimmer? Text(
                "From",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 12,
                  color:BrandColor.black,
                  fontWeight: FontWeight.w400
                ),
              ):Container(
                height: 16,
                width: 40,
                color: BrandColor.grey167,
              ), 
              SizedBox(height: 8,),
              isShimmer?Text(
                "Nebraska",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 18,
                  color:BrandColor.black,
                  fontWeight: FontWeight.w500
                ),
              ):Container(
                height: 26,
                width: 40,
                color: BrandColor.grey167,
              ),  
              SizedBox(height: 8,),
              Row(
                children: [
                  distance(1),
                  SizedBox(width: 5,),
                  distance(0),
                  SizedBox(width: 5,),
                  distance(0),
                ],
              ),
            ],
          ),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             isShimmer? Text(
                "To",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 12,
                  color:BrandColor.black,
                  fontWeight: FontWeight.w400
                ),
              ):Container(
                height: 16,
                width: 40,
                color: BrandColor.grey167,
              ), 
              SizedBox(height: 8,),
              isShimmer?Text(
                "California",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 18,
                  color:BrandColor.black,
                  fontWeight: FontWeight.w500
                ),
              ):Container(
                height: 26,
                width: 40,
                color: BrandColor.grey167,
              ),  
              SizedBox(height: 8,),
              Row(
                children: [
                  distance(0),
                  SizedBox(width: 5,),
                  distance(2),
                  SizedBox(width: 5,),
                  distance(0),
                ],
              ),
            ],
          )
         
          
        ],
      ),
    );
  }

  Widget distance( int type){
    Color color=BrandColor.grey227;
    if(type==1){
      color=BrandColor.green;
    }else if(type==2){
      color=BrandColor.blue;
    }else if(type==3){
      color=BrandColor.red193;
    }
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12)
      ),
      child: SvgPicture.asset("assets/svg/UI/distance.svg"),
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
      alignment: Alignment.center,
      child: SvgPicture.asset("assets/svg/UI/indicator_blue.svg"),
    );
  }

  Widget date(){
    if(!isShimmer){
      return Column(
        children: [
          Container(
            width: 60,
            height: 16,
            color: BrandColor.grey167,
          ),
          SizedBox(height: 8,),
          Container(
            width: 60,
            height: 26,
            color: BrandColor.grey167,
          )
        ],
      );
    }
    return SizedBox(
      width: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: 8,),
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
      ),
    );
  }
}
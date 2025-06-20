import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/extensions/string_first_upper_case.dart';

class FullOrderHeader extends StatelessWidget {
  final RideModel trip;
  const FullOrderHeader({super.key,required this.trip});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          date(),
          SizedBox(width: 12,),
          indicator(),
          SizedBox(width: 16,),
          Expanded(child: locations()),
        ],
      ),
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
               Text(
                "From",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 12,
                  color:BrandColor.black69,
                  fontWeight: FontWeight.w400
                ),
              ), 
              SizedBox(height: 8,),
              Text(
                trip.locations[0].city.toFirstUpperCace(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 20,
                  color:BrandColor.black69,
                  fontWeight: FontWeight.w500
                ),
              ),  
              SizedBox(height: 3,),
              Text(
                trip.locations[0].location,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 15,
                  color:BrandColor.black69,
                  fontWeight: FontWeight.w500
                ),
              ),  
            ],
          ),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(
                "To",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 12,
                  color:BrandColor.black69,
                  fontWeight: FontWeight.w400
                ),
              ), 
              SizedBox(height: 8,),
              Text(
                trip.locations[1].city.toFirstUpperCace(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 20,
                  color:BrandColor.black69,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 3,),
              Text(
                trip.locations[1].location,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 15,
                  color:BrandColor.black69,
                  fontWeight: FontWeight.w500
                ),
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

Widget date(){
    return SizedBox(
      width: 60,
      height: 195,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat("dd MMMM").format(trip.date),
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: "SF",
              fontSize: 12,
              color:BrandColor.black69,
              fontWeight: FontWeight.w400
            ),
          ), 
          SizedBox(height: 8,),
          Text(
            DateFormat('h:mm a').format(trip.date),
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: "SF",
              fontSize: 14,
              color:BrandColor.black69,
              fontWeight: FontWeight.w700
            ),
          ), 
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
      alignment: Alignment.center,
      child: SvgPicture.asset("assets/svg/UI/indicator_blue.svg"),
    );
  }
}
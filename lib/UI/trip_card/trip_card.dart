import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/core/models/trip.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/core/tools/color_generator.dart';
import 'package:izzi_ride_2/pages/actions_ride_page/actions_ride_provider/actions_ride_provider.dart';
import 'package:izzi_ride_2/pages/initial_user_data_page/initial_user_data_page.dart';
import 'package:shimmer/shimmer.dart';

class TripCard extends StatelessWidget {

  static TripCard shimmer(){
    return TripCard(trip: RideModel.nullable(), isShimmer: true);
  }
  static TripCard view({required RideModel trip}){
    return TripCard(trip: trip, isShimmer: false);
  }
  final RideModel trip;
  final bool isShimmer;
  const TripCard ({super.key,required this.trip,required this.isShimmer});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 322,
      ),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: BrandColor.grey167,
        ),
        borderRadius: BorderRadius.circular(17)
      ),
      child: Stack(
        children: [
          Builder(
            builder: (context) {
              if(!isShimmer){
                return Column(
                  children: [
                    Builder(
                      builder: (context) {
                        final newTravalers = trip.travalers.where((element) => element.statusName=="new",).toList();
                        final orderId=trip.orderId;
                        if(newTravalers.isEmpty){
                          return SizedBox.shrink();
                        }else{
                          return GestureDetector(
                            onTap: () {
                              actionsRideProvider.setNewTravalers(newTravalers,orderId);
                              context.goNamed(RoutesName.actionsRide);
                            },
                            child: Container(
                              height: 46,
                              margin: EdgeInsets.only(bottom: 24),
                              decoration: BoxDecoration(
                                color: BrandColor.verylightBlue,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Stack(
                                    children: [
                                      R.SVG.BellIcon,
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          height: 12,
                                          width: 12,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: BrandColor.red,
                                            borderRadius: BorderRadius.circular(12)
                                          ),
                                          child: Text(
                                            newTravalers.length.toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily: "SF",
                                              fontSize: 8,
                                              color:BrandColor.white,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        )
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    "New booking request",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: "SF",
                                      fontSize: 20,
                                      color:BrandColor.blue,
                                      fontWeight: FontWeight.w400
                                    ),
                                  )
                                ],
                              )
                              
                            ),
                          );
                        }
                      },
                    ),
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
                            avatar("",trip.driverNickname),
                            SizedBox(width: 12,),
                            driver(),
                          ],
                        ),
                        passangersAvatar()
                      ],
                    )
                  ],
                );
              }
              return Shimmer.fromColors(
                     enabled: true,
                    baseColor: BrandColor.grey217,
                    highlightColor: BrandColor.grey167,
                  
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
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
                            avatar("","MM"),
                            SizedBox(width: 12,),
                            driver(),
                          ],
                        ),
                        passangersAvatar()
                      ],
                    )
                  ],
                ),
              );
            }
          ),
          // Positioned(
          //   top: 100,
          //   child: Container(
          //     width: 40,
          //     height: 40,
          //     decoration: BoxDecoration(
          //       color: Colors.amber
          //     ),
              
          //   )
          // )
        ],
      ),
    );
  }

  Widget passangersAvatar(){
    return SizedBox(
      height: 44,
      width: 44+trip.travalers.length*22,
      child: Stack(
        children: [
          for(int i=0;i<trip.travalers.length;i++)
          Positioned(
            right: trip.travalers.length-i*22,
            child: avatar(trip.travalers[i].avatarUrl,trip.travalers[i].nickname)
          ),
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
              trip.driverNickname,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: "SF",
                fontSize: 18,
                color:BrandColor.black69,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(width: 8,),
            Text(
              "⭐ ${trip.driverRate}",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: "SF",
                fontSize: 18,
                color:BrandColor.black69,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        Text(
          trip.carName,
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

  Widget avatar(String avatarUrl,String nickname){
      return Container(
          alignment: Alignment.center,
          height: 44,
          width: 44,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.network(
              avatarUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: ColorGenerator.fromString("Mike D"),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    trip.driverNickname.isEmpty?"N":trip.driverNickname[0],
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "SF",
                      fontSize: 20,
                      color:Colors.white,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                );
              },
            ),
          ),
        
      );
    
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
            color:BrandColor.black69,
            fontWeight: FontWeight.w400
          ),
        ):Container(
          width: 50,
          height: 17,
          color: BrandColor.grey167,
        ), 
        SizedBox(height: 8,),
        !isShimmer?Text(
          "\$${trip.price.toInt()}",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "SF",
            fontSize: 20,
            color:BrandColor.black69,
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
          "${trip.freeSeats} of ${trip.totalSeats}",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "SF",
            fontSize: 18,
            color:BrandColor.black69,
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
               !isShimmer? Text(
                "From",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 12,
                  color:BrandColor.black69,
                  fontWeight: FontWeight.w400
                ),
              ):Container(
                height: 16,
                width: 40,
                color: BrandColor.grey167,
              ), 
              SizedBox(height: 8,),
              !isShimmer?Text(
                trip.startLocationName,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 18,
                  color:BrandColor.black69,
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
             !isShimmer? Text(
                "To",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 12,
                  color:BrandColor.black69,
                  fontWeight: FontWeight.w400
                ),
              ):Container(
                height: 16,
                width: 40,
                color: BrandColor.grey167,
              ), 
              SizedBox(height: 8,),
              !isShimmer?Text(
                trip.endLocationName,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 18,
                  color:BrandColor.black69,
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
    if(isShimmer){
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
          Expanded(
            child: SizedBox.shrink()
          ),
          GestureDetector(
            onLongPress: () {
              
            },
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: R.SVG.LightIcon
            ),
          )
        ],
      ),
    );
  }
}
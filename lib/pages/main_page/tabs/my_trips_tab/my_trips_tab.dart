import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/illustrations/empty_my_trips_illustartion.dart';
import 'package:izzi_ride_2/UI/trip_card/trip_card.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/rides_bloc/rides_bloc.dart';
import 'package:izzi_ride_2/core/models/enum_ride_status.dart';
import 'package:izzi_ride_2/core/models/trip.dart';


enum EStatusName{
  active,completed,cancelled
}


class MyTripsTab extends StatefulWidget {
  const MyTripsTab({super.key});

  @override
  State<MyTripsTab> createState() => _MyTripsTabState();
}

class _MyTripsTabState extends State<MyTripsTab> {

  EStatusName currentCategoryIndex=EStatusName.active;

  List<EnumRideStatus> statusesFromOrderStatus(EStatusName statusName){
    switch(statusName){
      case EStatusName.active: return [EnumRideStatus.created,EnumRideStatus.ongoing];
      case EStatusName.completed: return [EnumRideStatus.finished];
      case EStatusName.cancelled: return [EnumRideStatus.rejected,EnumRideStatus.canceled];
    }
  }

 

  int ridesCountWithCategory=0;

  @override
  Widget build(BuildContext context) {

    final ridesBlock=context.watch<RidesBloc>();
  
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 54,),
              Text(
                      "My trips",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "SF",
                        fontSize: 32,
                        color: BrandColor.black69,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    SizedBox(height: 102,),
                    Builder(
                      builder: (context) {
                        final ridesBlock=context.watch<RidesBloc>();
                        final ridesBlockState=ridesBlock.state;
                        if(ridesBlockState.rides==null){
                          ridesBlock.add(RidesGetUserRides());
                          return Expanded(child: TripCard.shimmer()); 
                        }
                        if(ridesBlockState.requsted){
                          return Expanded(child: TripCard.shimmer()); 
                        }
                        if(ridesBlockState.rides!.isEmpty){
                          return Expanded(
                            child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: EmptyMyTripsIllustartion(),
                              )
                          );
                        }
                        final rides = ridesBlockState.rides!.where((element) => statusesFromOrderStatus(currentCategoryIndex).contains(element.rideStatus),).toList();
                        ridesCountWithCategory=rides.length;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: rides.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    
                                    context.pushNamed(RoutesName.orderFullInfo,extra: {"orderId":rides[index].orderId,"currentSeatsInfo":1});
                                  },
                                  child: TripCard.view(trip:rides[index])
                                ),
                              );
                            },
                          ),
                        );
                      }
                    ),
                    
            ],
          ),
        ),
        Positioned(
          top: 120,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 34,
            child: Builder(
              builder: (context) {
                final ridesBlock=context.watch<RidesBloc>();
                final ridesBlockState=ridesBlock.state;
                int active = ridesBlockState.rides==null?0:ridesBlockState.rides!.where((element) => statusesFromOrderStatus(EStatusName.active).contains(element.rideStatus)).length;
                int completed = ridesBlockState.rides==null?0:ridesBlockState.rides!.where((element) => statusesFromOrderStatus(EStatusName.completed).contains(element.rideStatus)).length;
                int cancelled = ridesBlockState.rides==null?0:ridesBlockState.rides!.where((element) => statusesFromOrderStatus(EStatusName.cancelled).contains(element.rideStatus)).length;
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 24,),
                    filterCategory(EStatusName.active,"Active",active),
                    SizedBox(width: 16,),
                    filterCategory(EStatusName.completed,"Completed",completed),
                    SizedBox(width: 16,),
                    filterCategory(EStatusName.cancelled,"Cancelled",cancelled),
                    SizedBox(width: 24,),
                
                  ],
                );
              }
            ),
          )
        )
      ],
    );
  }

  Widget filterCategory(EStatusName categoryIndex,String title,int count){
    return GestureDetector(
      onTap: () {
        setState(() {
          currentCategoryIndex=categoryIndex;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32,vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: categoryIndex==currentCategoryIndex?BrandColor.lightBlue:BrandColor.grey227
        ),
        child:Text(
                title+" "+count.toString(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 15,
                  color:categoryIndex==currentCategoryIndex? BrandColor.blue:BrandColor.grey167,
                  fontWeight: FontWeight.w600
                ),
              ), 
        
      ),
    );
  }

}
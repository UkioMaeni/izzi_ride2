import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/illustrations/empty_my_trips_illustartion.dart';
import 'package:izzi_ride_2/UI/trip_card/trip_card.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/rides_bloc/rides_bloc.dart';
import 'package:izzi_ride_2/core/models/trip.dart';

class MyTripsTab extends StatefulWidget {
  const MyTripsTab({super.key});

  @override
  State<MyTripsTab> createState() => _MyTripsTabState();
}

class _MyTripsTabState extends State<MyTripsTab> {

  int currentCategoryIndex=0;

  @override
  Widget build(BuildContext context) {
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
                        color: BrandColor.black,
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
                          return TripCard.shimmer(); 
                        }
                        if(ridesBlockState.requsted){
                          return TripCard.shimmer(); 
                        }
                        if(ridesBlockState.rides!.isEmpty){
                          return Expanded(
                            child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: EmptyMyTripsIllustartion(),
                              )
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount: ridesBlockState.rides!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    context.pushNamed(RoutesName.orderFullInfo,extra: ridesBlockState.rides![index].orderId);
                                  },
                                  child: TripCard.view(trip:ridesBlockState.rides![index])
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 24,),
                filterCategory(0,"Active"),
                SizedBox(width: 16,),
                filterCategory(1,"Completed"),
                SizedBox(width: 16,),
                filterCategory(2,"Cancelled"),
                SizedBox(width: 24,),

              ],
            ),
          )
        )
      ],
    );
  }

  Widget filterCategory(int categoryIndex,String title){
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
                title,
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
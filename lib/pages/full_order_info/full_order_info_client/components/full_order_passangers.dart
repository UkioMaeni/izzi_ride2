import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/pages/full_order_info/full_order_info_client/components/user_info.dart';

class FullOrderPassangers extends StatelessWidget {
  final RideModel trip;
  final int currentNumberOfSeats;
  const FullOrderPassangers({super.key,required this.trip,required this.currentNumberOfSeats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Travelers",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 25,
                  color:BrandColor.black69,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(width: 5,),
              // Builder(
              //   builder: (context) {
              //     String seatcsInfo = trip.travalers.""
              //     return Text(
              //       "3/5 are free",
              //       textAlign: TextAlign.start,
              //       style: TextStyle(
              //         fontFamily: "SF",
              //         fontSize: 20,
              //         color:BrandColor.blue,
              //         fontWeight: FontWeight.w500
              //       ),
              //     );
              //   }
              // ),
            ],
          ),
          SizedBox(height: 20,),
          
          Builder(
            builder: (context) {
              
              final traveler = trip.travalers.where((element) => element.statusId!=1,).toList();
              return Column(
                children: [
                  for(int i=0;i<traveler.length;i++ )
                  Column(
                    children: [
                      Row(
                        children: [
                          UserInfo(
                            photoUrl: traveler[i].avatarUrl,
                            name: traveler[i].name,
                            rate: traveler[i].rate,
                            isNovice: true,
                          ),
                          Expanded(child: SizedBox.shrink()),
                          Container(
                            // child: Text(
                            //     "View profile",
                            //     style: TextStyle(
                            //       fontFamily: BrandFontFamily.platform,
                            //       fontSize: 15,
                            //       color: BrandColor.blue,
                            //       fontWeight: FontWeight.w800
                            //     ),
                            //   ),
                            child: Icon(Icons.chevron_right,size: 40,color: BrandColor.black69,),
                          )
                        ],
                      ),
                      traveler[i].numberOfSeats>1?
                        SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              SizedBox(width: 28,),
                              Container(
                                height: 40,
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 21,
                                  width: 2,
                                  color: BrandColor.grey,
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 2,
                                color: BrandColor.grey,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                "And ${traveler[i].numberOfSeats-1} more guests",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: "SF",
                                  fontSize: 18,
                                  color:BrandColor.blue,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        )
                        :SizedBox(height: 10,)
                    ],
                  ),
                  
                ],
              );
            }
          ),
          
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:izzi_ride_2/UI/user_photo.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/full_order_info/full_order_info_client/components/user_info.dart';

class FullOrderDriverAbout extends StatefulWidget {
  final RideModel trip;
  const FullOrderDriverAbout({super.key,required this.trip});

  @override
  State<FullOrderDriverAbout> createState() => _FullOrderDriverAboutState();
}

class _FullOrderDriverAboutState extends State<FullOrderDriverAbout> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              SizedBox(height: 10,),
              Row(
                children: [
                  
                  UserInfo(
                    photoUrl: widget.trip.driverPhoto,
                    name: widget.trip.driverNickname,
                    rate: widget.trip.driverRate,
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
              
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      Icon(Icons.directions_car),
                      SizedBox(width: 5,),
                      Text(
                        widget.trip.carInfo!.fullName,
                        style: TextStyle(
                          fontFamily: BrandFontFamily.platform,
                          fontSize: 22,
                          color: BrandColor.black,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Text(
                          "View car in iZZiGraphy >",
                          style: TextStyle(
                            //decoration: TextDecoration.underline,
                            decorationColor: BrandColor.blue,
                            fontFamily: BrandFontFamily.platform,
                            fontSize: 15,
                            color: BrandColor.blue,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                  ),
                  // Text(
                  //   "Car",
                  //   style: TextStyle(
                  //     fontFamily: BrandFontFamily.platform,
                  //     fontSize: 15,
                  //     color: BrandColor.black,
                  //     fontWeight: FontWeight.w500
                  //   ),
                  // ),
                  
                ],
              )
            ],
          ),
          SizedBox(height: 5,),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Preferenses:",
              //   style: TextStyle(
              //     fontFamily: BrandFontFamily.platform,
              //     fontSize: 15,
              //     color: BrandColor.black,
              //     fontWeight: FontWeight.w800
              //   ),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(),
                  Builder(
                    builder: (context) {
                      Widget child = R.SVG.PreferenseChildSeatsON;
                      String text = "asdasdad";
                      if(!widget.trip.additional.babyChaire){
                        child=R.SVG.PreferenseChildSeatsOFF;
                        text = "asdasdad";
                      }
                      return Row(
                        children: [
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: child
                          ),
                          SizedBox(width: 5,),
                          Text(
                            text,
                            style: TextStyle(
                              //decoration: TextDecoration.underline,
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 15,
                              color: BrandColor.black69,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                  Builder(
                    builder: (context) {
                      Widget child = R.SVG.PreferenseLuggageON;
                      String text = "asdasdad";
                      if(!widget.trip.additional.luggage){
                        child=R.SVG.PreferenseLuggageOFF;
                        text = "asdasdad";
                      }
                      return Row(
                        children: [
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: child
                          ),
                          SizedBox(width: 5,),
                          Text(
                            text,
                            style: TextStyle(
                              //decoration: TextDecoration.underline,
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 15,
                              color: BrandColor.black69,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                  Builder(
                    builder: (context) {
                      Widget child = R.SVG.PreferenseSmokeON;
                      String text = "asdasdad";
                      if(!widget.trip.additional.smoking){
                        child=R.SVG.PreferenseSmokeOFF;
                        text = "asdasdad";
                      }
                      return Row(
                        children: [
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: child
                          ),
                          SizedBox(width: 5,),
                          Text(
                            text,
                            style: TextStyle(
                              //decoration: TextDecoration.underline,
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 15,
                              color: BrandColor.black69,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                  Builder(
                    builder: (context) {
                      Widget child = R.SVG.PreferenseAnimalON;
                      String text = "asdasdad";
                      if(!widget.trip.additional.animals){
                        child=R.SVG.PreferenseAnimalOFF;
                        text = "asdasdad";
                      }
                      return Row(
                        children: [
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: child
                          ),
                          SizedBox(width: 5,),
                          Text(
                            text,
                            style: TextStyle(
                              //decoration: TextDecoration.underline,
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 15,
                              color: BrandColor.black69,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ],
                      );
                    }
                  )
                ],
              )
              
            ],
          ),
        ],
      ),
    );
  }
}
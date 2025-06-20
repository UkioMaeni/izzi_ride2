import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/UI/user_photo.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:izzi_ride_2/core/bloc/rides_bloc/rides_bloc.dart';
import 'package:izzi_ride_2/core/models/travaler_model.dart';
import 'package:izzi_ride_2/core/tools/color_generator.dart';
import 'package:izzi_ride_2/pages/actions_ride_page/actions_ride_provider/actions_ride_provider.dart';
import 'package:provider/provider.dart';

class ActionsRidePage extends StatefulWidget {
  const ActionsRidePage({super.key});

  @override
  State<ActionsRidePage> createState() => _ActionsRidePageState();
}

class _ActionsRidePageState extends State<ActionsRidePage> {

  Future<void> approve(int appId,int orderId,int travalerId,)async{
   final result = await actionsRideProvider.approve(appId);
   if(result==true){
    editStatusTravalerInRide(orderId,travalerId,"accepted");
    goMainPage();
   }else{

   }
  }
  Future<void> reject(int appId,int orderId,int travalerId,)async{
    final result = await actionsRideProvider.approve(appId);
    if(result==true){
      editStatusTravalerInRide(orderId,travalerId,"rejected");
    goMainPage();
   }else{

   }
  }

  editStatusTravalerInRide(int orderId,int travalerId, String status){
    context.read<RidesBloc>().add(RidesEditStatusTravalerInRide(orderId: orderId,travalerId: travalerId,status: status));
  }
  goMainPage(){
    log("goMainPage");
    context.goNamed(RoutesName.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandColor.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: BrandColor.white,
      ),
      body: Consumer<ActionsRideProvider>(
        builder: (context, action, child) {
          log(action.newTravalers.toString());
          if(action.newTravalers.isEmpty){
            return Text("Oops");
          }
          final currentTravalers = action.newTravalers[0];
          String currentTravalersNickname="";
          if(currentTravalers.nickname.isEmpty){
            currentTravalersNickname="!";
          }else{
            currentTravalersNickname=currentTravalers.nickname;
          }
          double rate = currentTravalers.rate;
          int applicationId = currentTravalers.applicationId;
          int orderId = action.currentOrderId;
          int travalerId = currentTravalers.id;
          int numberOfSeats = currentTravalers.numberOfSeats;
          String currentTravalersNameSurname = currentTravalers.name+" "+currentTravalers.surname;
          String bio = currentTravalers.bio+"asd asd asdasdasd asdasd ad12ed 12d1 2d1 d 1212d1d21d 12d12d1d1d1d 21d1d11 21d121d1d ";
          log(currentTravalers.bio);
          return Column(
            
            children: [
              NavBar(title: "View actions",),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Text(
                        "Approve The\nPassenger's Booking",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "SF",
                          fontSize: 32,
                          color:BrandColor.black69,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 50,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: UIUserPhoto(url: currentTravalers.avatarUrl,size: Size(150, 150),),
                                // child: Image.network(
                                //   currentTravalers.avatarUrl,
                                //   errorBuilder: (context, error, stackTrace) {
                                //     return Container(
                                //       color: ColorGenerator.fromString(currentTravalersNickname),
                                //       alignment: Alignment.center,
                                //       child: Text(
                                //         currentTravalersNickname[0],
                                //         textAlign: TextAlign.center,
                                //         style: TextStyle(
                                //           fontFamily: "SF",
                                //           fontSize: 40,
                                //           color:BrandColor.black69,
                                //           fontWeight: FontWeight.w700
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              rate.toInt().toString()+" ⭐",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "SF",
                                fontSize: 15,
                                color:BrandColor.black69,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            Text(
                              currentTravalersNameSurname,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "SF",
                                fontSize: 24,
                                color:BrandColor.black69,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            
                            Text("bio"),
                            Container(
                              constraints: BoxConstraints(
                                minHeight: 50,
                                
                              ),
                              decoration: BoxDecoration(
                                color: BrandColor.verylightBlue,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),

                                )
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                bio,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "SF",
                                  fontSize: 15,
                                  color:BrandColor.black69,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                            UIButton(label: "See profile",reverse: true,),
                            Text(
                              "Request ${numberOfSeats} seats"
                            )
                          ],
                        ),
                      ),
                      UIButton(label: "Approve",onFuture:() async=> await approve(applicationId,orderId,travalerId),),
                      UIButton(label: "Reject",reverse: true,onFuture:() async=> await reject(applicationId,orderId,travalerId)),
                      SizedBox(height: 24,),
                      Text(
                        "Please contact the passenger to confirm the booking details.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "SF",
                          fontSize: 12,
                          color:BrandColor.black69,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
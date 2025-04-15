import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/core/http/order_http.dart';
import 'package:izzi_ride_2/core/models/enum_role.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_data.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_location.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_time.dart';
import 'package:izzi_ride_2/pages/full_order_info/full_order_info_client.dart';
import 'package:izzi_ride_2/pages/full_order_info/full_order_info_driver.dart';

class FullOrderInfo extends StatefulWidget {
  final int orderId;
  const FullOrderInfo({super.key,required this.orderId});

  @override
  State<FullOrderInfo> createState() => _FullOrderInfoState();
}

class _FullOrderInfoState extends State<FullOrderInfo> {


  

  Future<void> bookRide()async{

  }

  RideModel? trip;

  getTripFromId()async{
    log("getTripFromId");
   final result= await  OrderHttp.I.getOrderFullInfo(widget.orderId);
   if(result is CustomResponse<RideModel>){
    setState(() {
      trip=result.data;
    });
   }
  }
  
  @override
  void initState() {
    getTripFromId();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          NavBar(title: "trip! information",),
          Builder(
            builder: (context) {
              if(trip==null){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(trip!.role==Role.driver){
                return Expanded(child: FullOrderInfoDriver(trip: trip!,));
              }
              if(trip!.role==Role.client){
                return Expanded(
                  child: FullOrderInfoClient(
                    trip: trip!,
                    updateState: getTripFromId,
                  )
                );
              }
              return SizedBox.shrink();
            }
          )
        ],
      ),
    );
  }
}
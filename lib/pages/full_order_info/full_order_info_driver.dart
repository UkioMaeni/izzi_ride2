import 'package:flutter/material.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/core/http/order_http.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_data.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_location.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_time.dart';

class FullOrderInfoDriver extends StatelessWidget {
  final RideModel trip;
  const FullOrderInfoDriver({super.key,required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      FullOrderLocation(trip: trip,),
                      FullOrderData(trip: trip,),
                      FullOrderTime(trip: trip,),
                      SizedBox(height: 40,),
                      // UIButton(
                      //   label: "Book now",
                      //   onFuture: bookRide,
                      // )
                    ],
                  ),
                ),
              )
    );
  }
  
}

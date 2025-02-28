import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/core/http/chat_http.dart';
import 'package:izzi_ride_2/core/http/order_http.dart';
import 'package:izzi_ride_2/core/models/enum_ride_booked_status.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_data.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_location.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_time.dart';

class FullOrderInfoClient extends StatefulWidget {
  final RideModel trip;
  final Function() updateState;
  const FullOrderInfoClient({super.key,required this.trip,required this.updateState});

  @override
  State<FullOrderInfoClient> createState() => _FullOrderInfoClientState();
}

class _FullOrderInfoClientState extends State<FullOrderInfoClient> {

  Future<void> bookRide()async{
    final seats= context.read<SearchRideBloc>().state.personCount;
    final result = await OrderHttp.I.bookOrder(widget.trip.orderId,seats);
    if(result is CustomResponse<bool>){
      widget.updateState();
    }
  }

  Future<void> contactWithDriver()async{
   final result= await ChatHttp.I.getChatId(widget.trip.orderId, widget.trip.creatorId);
   if(result is CustomResponse<int>){
    int chatId=result.data;
    
   }
  }
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
                      FullOrderLocation(trip: widget.trip,),
                      FullOrderData(trip: widget.trip,),
                      FullOrderTime(trip: widget.trip,),
                      SizedBox(height: 40,),
                      Builder(
                        builder: (context) {
                          if(widget.trip.rideBookedStatus==EnumRideBookedStatus.unbooked){
                            return UIButton(
                              label: "Book now",
                              onFuture: bookRide,
                            );
                          }
                          if(widget.trip.rideBookedStatus==EnumRideBookedStatus.pending){
                            return Text(
                              "pending",
                            );
                          }
                          if(widget.trip.rideBookedStatus==EnumRideBookedStatus.accepted){
                            return Column(
                              children: [
                                UIButton(
                                  label: "Cancel booking",
                                  onFuture: bookRide,
                                ),
                                UIButton(
                                  label: "Contact the driver",
                                  reverse: true,
                                  onFuture: contactWithDriver,
                                ),
                              ],
                            );
                          }
                          return SizedBox.shrink();
                        }
                      ),
                      SizedBox(height: 40,)
                    ],
                  ),
                ),
              )
    );
  }
}

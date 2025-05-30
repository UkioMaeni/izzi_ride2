import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/UI/user_photo.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/core/http/chat_http.dart';
import 'package:izzi_ride_2/core/http/order_http.dart';
import 'package:izzi_ride_2/core/models/enum_ride_booked_status.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/core/providers/chat_provider.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_data.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_location.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_time.dart';
import 'package:izzi_ride_2/pages/full_order_info/full_order_info_client/components/full_order_header.dart';

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
  Future<void> cancelBooked()async{
    final seats= context.read<SearchRideBloc>().state.personCount;
    final result = await OrderHttp.I.cancelBooking(widget.trip.orderId,"");
    if(result is CustomResponse<bool>){
      widget.updateState();
    }
  }

  Future<void> contactWithDriver()async{
   final result= await ChatHttp.I.getChatId(widget.trip.orderId, widget.trip.creatorId);
   if(result is CustomResponse<int>){
    int chatId=result.data;
    chatProvider.setCurrentChat(chatId);
    context.pushNamed(RoutesName.chat);
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
                  padding: const EdgeInsets.only(left: 24,right: 24,top: 20),
                  child: Column(
                    children: [
                      FullOrderHeader(trip: widget.trip),
                      SizedBox(height: 10,),
                      Divider(),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          UIUserPhoto(url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmBWslMrGzvqpWSsj0MzdfkRh4z4n2pAmdhg&s"),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.trip.driverNickname,
                                style: TextStyle(
                                  fontFamily: BrandFontFamily.platform,
                                  fontSize: 15,
                                  color: BrandColor.black,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "⭐ "+widget.trip.driverRate.toString(),
                                    style: TextStyle(
                                      fontFamily: BrandFontFamily.platform,
                                      fontSize: 15,
                                      color: BrandColor.black,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Novice",
                                    style: TextStyle(
                                      fontFamily: BrandFontFamily.platform,
                                      color: BrandColor.black69,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  if(true) SvgPicture.asset("assets/svg/profile/verify.svg",width: 12,height: 12,)
                                ],
                              )
                            ],
                          ),
                          Expanded(child: SizedBox.shrink()),
                          Container(
                            child: Text(
                                "View profile",
                                style: TextStyle(
                                  fontFamily: BrandFontFamily.platform,
                                  fontSize: 15,
                                  color: BrandColor.blue,
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment",
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 13,
                                    color: BrandColor.black,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                Text(
                                  "Cash",
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 15,
                                    color: BrandColor.black,
                                    fontWeight: FontWeight.w800
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Price",
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 13,
                                    color: BrandColor.black,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                Text(
                                  "\$"+widget.trip.price.toString(),
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 15,
                                    color: BrandColor.black,
                                    fontWeight: FontWeight.w800
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Service fee",
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 13,
                                    color: BrandColor.black,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                Text(
                                  "\$"+widget.trip.price.toString(),
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 15,
                                    color: BrandColor.black,
                                    fontWeight: FontWeight.w800
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Preferenses: ",
                            style: TextStyle(
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 15,
                              color: BrandColor.black,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ],
                      ),




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
                                  onFuture: cancelBooked,
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/modals/guide_bottom_sheet.dart';
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
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/full_order_divider.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_data.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_location.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/preview_time.dart';
import 'package:izzi_ride_2/pages/full_order_info/full_order_info_client/components/full_order_driver_about.dart';
import 'package:izzi_ride_2/pages/full_order_info/full_order_info_client/components/full_order_header.dart';
import 'package:izzi_ride_2/pages/full_order_info/full_order_info_client/components/full_order_passangers.dart';
import 'package:izzi_ride_2/pages/full_order_info/full_order_info_client/components/full_order_price.dart';

class FullOrderInfoClient extends StatefulWidget {
  final RideModel trip;
  final Function() updateState;
  final int currentNumberOfSeats;
  const FullOrderInfoClient({super.key,required this.trip,required this.updateState,required this.currentNumberOfSeats});

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
    // final seats= context.read<SearchRideBloc>().state.personCount;
    // final result = await OrderHttp.I.cancelBooking(widget.trip.orderId,"");
    // if(result is CustomResponse<bool>){
    //   //widget.updateState();
      
    // }
    context.goNamed(RoutesName.orderFullInfoCancelIllustration);
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
      
      body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      FullOrderHeader(trip: widget.trip),
                      SizedBox(height: 20,),
                      FullOrderDriverAbout(trip: widget.trip),
                      SizedBox(height: 10,),
                      FullOrderDivider(),
                      SizedBox(height: 10,),
                      FullOrderPrice(trip: widget.trip,currentNumberOfSeats:widget.currentNumberOfSeats),
                      SizedBox(height: 10,),
                      FullOrderDivider(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
                        child: Column(
                          children: [
                            Text(
                              "Geolocation",
                              style: TextStyle(
                                fontFamily: BrandFontFamily.platform,
                                fontSize: 26,
                                color: BrandColor.black,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context, 
                                  useSafeArea: false,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return UIGuideBottomSheet(
                                      type: EUIGuideBottomSheetType.location,
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline,color: BrandColor.black69,size: 20,),
                                  Text(
                                    "Advice",
                                    style: TextStyle(
                                      fontFamily: BrandFontFamily.platform,
                                      fontSize: 15,
                                      color: BrandColor.black69,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Text(
                                  "Start geolocation stream for visible geo Start geolocation stream for visible geo Start geolocation stream for visible geo",
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 15,
                                    color: BrandColor.black69,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () {
                                     Clipboard.setData(ClipboardData(text: "vk.com/dsadaasdasdasdad255")); 
                                     ScaffoldMessenger.of(context).showSnackBar(

                                        SnackBar(content: Center(child: Text('Текст скопирован')),duration: Duration(milliseconds: 600),),
                                      );
                                    },
                                    child: Container(
                                      constraints: BoxConstraints(
                                        minWidth: 100
                                      ),
                                      decoration: BoxDecoration(
                                        color: BrandColor.grey214,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      //alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "vk.com/dsadaasdasdasdad255",
                                            style: TextStyle(
                                              fontFamily: BrandFontFamily.platform,
                                              fontSize: 16,
                                              color: BrandColor.black69,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Icon(Icons.copy,color: BrandColor.black69,size: 20,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 100),
                              child: UIButton(label: "Stream location",height: 50,),
                            ),
                            
                          ],
                        ),
                      ),
                      FullOrderDivider(),
                      SizedBox(height: 10,),
                      FullOrderPassangers(trip: widget.trip,currentNumberOfSeats:widget.currentNumberOfSeats),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "Payment",
                      //             style: TextStyle(
                      //               fontFamily: BrandFontFamily.platform,
                      //               fontSize: 13,
                      //               color: BrandColor.black,
                      //               fontWeight: FontWeight.w500
                      //             ),
                      //           ),
                      //           Text(
                      //             "Cash",
                      //             style: TextStyle(
                      //               fontFamily: BrandFontFamily.platform,
                      //               fontSize: 15,
                      //               color: BrandColor.black,
                      //               fontWeight: FontWeight.w800
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),

                      //     //ds
                      //     Expanded(
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "Price",
                      //             style: TextStyle(
                      //               fontFamily: BrandFontFamily.platform,
                      //               fontSize: 13,
                      //               color: BrandColor.black,
                      //               fontWeight: FontWeight.w500
                      //             ),
                      //           ),
                      //           Text(
                      //             "\$"+widget.trip.price.toString(),
                      //             style: TextStyle(
                      //               fontFamily: BrandFontFamily.platform,
                      //               fontSize: 15,
                      //               color: BrandColor.black,
                      //               fontWeight: FontWeight.w800
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             "Service fee",
                      //             style: TextStyle(
                      //               fontFamily: BrandFontFamily.platform,
                      //               fontSize: 13,
                      //               color: BrandColor.black,
                      //               fontWeight: FontWeight.w500
                      //             ),
                      //           ),
                      //           Text(
                      //             "\$"+widget.trip.price.toString(),
                      //             style: TextStyle(
                      //               fontFamily: BrandFontFamily.platform,
                      //               fontSize: 15,
                      //               color: BrandColor.black,
                      //               fontWeight: FontWeight.w800
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // ),

                      // Expanded(child: SizedBox()),
                      // FullOrderLocation(trip: widget.trip,),
                      // FullOrderData(trip: widget.trip,),
                      // FullOrderTime(trip: widget.trip,),
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Builder(
                          builder: (context) {
                            if(widget.trip.rideBookedStatus==EnumRideBookedStatus.unbooked){
                              return UIButton(
                                label: "Book now",
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Book now",
                                        style: TextStyle(
                                          fontFamily: BrandFontFamily.platform,
                                          fontSize: 18,
                                          color: BrandColor.white,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      SizedBox(width: 3,),
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: R.SVG.LightIcon_White
                                      )
                                  ],
                                ),
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
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              )
    );
  }
}

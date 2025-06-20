import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/http/order_http.dart';
import 'package:izzi_ride_2/core/models/enum_ride_status.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/pages/full_order_info/components/full_order_divider.dart';
import 'package:izzi_ride_2/pages/full_order_info/full_order_info_client/components/full_order_driver_about.dart';
import 'package:izzi_ride_2/pages/full_order_info/full_order_info_client/components/full_order_header.dart';
import 'package:izzi_ride_2/pages/full_order_info/full_order_info_client/components/user_info.dart';

class ViewStreamLocationPage extends StatefulWidget {
  final String hash;
  const ViewStreamLocationPage({super.key,required this.hash});

  @override
  State<ViewStreamLocationPage> createState() => _ViewStreamLocationPageState();
}

class _ViewStreamLocationPageState extends State<ViewStreamLocationPage> {

  final Completer<GoogleMapController> _completer=Completer<GoogleMapController>();
  late GoogleMapController _mapController;
  bool _mapControllerIsInitialize = false;

  RideModel? model;


  Future<void> getModelFromHash()async{
    final result =await  OrderHttp.I.getOrderInfoFromHash(widget.hash);
    if(result is CustomResponse<RideModel>){
      model = result.data;
      await addMarker(model!.latLng!);
    }
    if(mounted){
      setState(() {});
    }
  }

  @override
  void initState() {
    getModelFromHash();
    super.initState();
  }

  @override
  void dispose() {
    model=null;
    _mapController.dispose();
    secondTimer?.cancel();
    timer?.cancel();
    super.dispose();
  }

  Set<Marker> _markers = Set();

  addMarker(LatLng position)async{
    _markers=Set();
    final icon = await BitmapDescriptor.asset(ImageConfiguration(size: Size(40, 40)), "assets/image/icons/current_geo.png");
    final marker =  Marker(markerId: MarkerId("asdad"),icon: icon,position: position);
     _markers.add(marker);
     if(_mapControllerIsInitialize){
        _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: position,zoom: 12)));
     }
  setState(() {
    
  });
  }


  Timer? secondTimer;
  int seconds=0;


  String lastUpdate = "now";

  startSecondTimer(){
    secondTimer=Timer.periodic(
      Duration(seconds: 1), (timer) {
        setState(() {
             seconds=seconds+1;
        });
       
      },
    );
  }

  Timer? timer;

  bool isPooled = false;

  startPooling(){
    if(isPooled) return;
    isPooled=true;
    startSecondTimer();
    timer = Timer.periodic(
      Duration(seconds: 10), (timer) async{
          final result =await OrderHttp.I.getLocationFromHash(widget.hash);
          if(result is CustomResponse<LatLng> && mounted){
            log("message");
            addMarker(result.data);
            seconds=0;
            secondTimer?.cancel();
            startSecondTimer();
          }
      },
    );
  }

  @override
  Widget build(BuildContext context) {



    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: BrandColor.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: BrandColor.white,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 24),
              child: Icon(Icons.close,size: 40,),
            ),
          ),
          Expanded(
            child: Builder(
              
              builder: (context) {
                if(model==null){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20,),
                      Text(
                        "Loading order data",
                        style: TextStyle(
                          fontFamily: BrandFontFamily.platform,
                          fontSize: 15,
                          color:BrandColor.black,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  );
                }
                
                startPooling();
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                          "User location",
                          style: TextStyle(
                            fontFamily: BrandFontFamily.platform,
                            fontSize: 25,
                            color:BrandColor.black,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      SizedBox(height: 10,),
                      
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            decoration: BoxDecoration(
                              
                            ),
                            
                            height: height*0.3,
                            child: GoogleMap(
                              buildingsEnabled: true,
                              compassEnabled: false,
                              indoorViewEnabled: false,
                            
                              zoomControlsEnabled: false,
                              
                              markers:_markers,
                              myLocationButtonEnabled: false,
                              initialCameraPosition: CameraPosition(target: model!.latLng!,zoom: 12),
                              // onTap: (argument) {
                              //   setState(() {
                              //     _markers=_markers.map((el) =>Marker(
                              //       markerId: MarkerId("0"),
                              //       position: LatLng(argument.latitude, argument.longitude)
                              //       )).toSet();
                              //   });
                              //   getResult(argument.latitude,argument.longitude);
                              // },
                              mapType: MapType.normal,
                              
                              onMapCreated: (controller) async {
                                print('COMPLETED');
                                _completer.complete(controller);
                                _mapController=await _completer.future;
                                _mapControllerIsInitialize = true;
                                //updateMapVisualWithNewGeo(LatLng(widget.mapParams.lat, widget.mapParams.lon));
                              },
                              onCameraMove: (position)async {
                                //final bounds = await _controller.getLatLng(const ScreenCoordinate(x: 0, y: 0));
                                
                              },
                              //onTap: updateMapVisualWithNewGeo,
                            
                              onCameraIdle: () async {
                              },
                            
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(),
                            Text(
                              "Last time update: ${seconds} seconds ago",
                              style: TextStyle(
                                fontFamily: BrandFontFamily.platform,
                                fontSize: 20,
                                color:BrandColor.black69,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(height: 20,),
                            UserInfo(
                              photoUrl: model!.driverPhoto,
                              name: model!.driverName,
                              rate: model!.driverRate,
                              isNovice: true,
                            ),
                            
                            //FullOrderDriverAbout(trip: model!),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      FullOrderDivider(),
                      SizedBox(height: 20,),
                      // Container(
                      //   child: Builder(builder: (context) {
                      //     String text = "";
                      //     switch(model!.rideStatus){
                      //       case EnumRideStatus.created: text = "created";
                      //       break;
                      //       case EnumRideStatus.canceled: text = "created";
                      //       break;
                      //       case EnumRideStatus.error: text = "created";
                      //       break;
                      //       case EnumRideStatus.finished: text = "created";
                      //       break;
                      //       case EnumRideStatus.ongoing: text = "created";
                      //       break;
                      //       case EnumRideStatus.rejected: text = "created";
                      //       break;
                      //     }
                      //     return Text("");
                      //   },),
                      // ),
                      FullOrderHeader(trip: model!),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                
                                Icon(Icons.directions_car),
                                SizedBox(width: 5,),
                                Text(
                                  model!.carInfo!.fullName,
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
                            
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      //FO_InfoInTheMap(location: Location.empty (),),
                      //Text(widget.hash)
                    ],
                  ),
                );
              },
            ),
          )
          
        ],
      ),
    );
  }
}




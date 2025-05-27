import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/google_map_ui.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/geocoding.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/core/tools/debounce.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/calendare_scene/calendare_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/to_input_scene.dart';

class ToMapScene extends StatefulWidget {
  const ToMapScene({super.key});

  @override
  State<ToMapScene> createState() => _ToMapSceneState();
}

class _ToMapSceneState extends State<ToMapScene> {

  final debounceTool = Debounce(duration: Duration(milliseconds: 500));

  Geocoding? geocoding;
  bool isLockedButton=true;

  double currentLat=0;
  double currentLon=0;

  Future<void> getDescriptionFromGoogle(double lat,double lon)async{
    setState(() {
      isLockedButton=true;
    });

    final result =await UserHttp().geocodingFromGoogle(lat,lon);
    if(result is CustomResponse<Geocoding>){
      setState(() {
        geocoding=result.data;
        currentLat=lat;
        currentLon=lon;
      });
    }
    setState(() {
      isLockedButton=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state= context.read<CreateRideBloc>().state;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 36),
              height: 50,
              alignment: Alignment.centerLeft,
              child: R.SVG.NavigationBackIcon,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMapUi(
                  mapParams: state.toMapParams,
                  onCameraIdle: (lat, lon) {
                    debounceTool.debounce(()=>getDescriptionFromGoogle(lat,lon));
                  },
                ),
                Positioned(
                  bottom: 44,
                  right: 24,
                  left: 24,
                  child: UIButton(label: "Next",
                    onTap: () {
                      print("object");
                      setState(() {
                        isLockedButton=true;
                      });
                      Location location = Location(
                          city: geocoding!.city,
                          state: geocoding!.state,
                          sortId: 1,
                          pickUp: true,
                          location: geocoding!.city,
                          longitude: currentLon,
                          latitude: currentLat,
                          stateShort: geocoding!.stateShort,
                          street: geocoding!.street,
                          homeNumber: geocoding!.homeNumber,
                          departureTime: DateTime.now()
                        );
                        context.read<CreateRideBloc>().add(CreateRideSetToLocation(location: location));
                        inspect(location);
                        setState(() {
                          isLockedButton=false;
                        });
                        context.goNamed(RoutesName.createCalendare);
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => CalendareScene(),));
                    },
                    enabled: !isLockedButton,
                  )
                ),
                Positioned(
                  top: 16,
                  right: 24,
                  left: 24,
                  child: Builder(
                    builder: (context) {
                      if(geocoding == null){
                              return Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 20,
                                  width: 20, 
                                child: CircularProgressIndicator(color: BrandColor.black69,)),
                              );
                            }
                      return Container(
                        constraints: BoxConstraints(
                          minHeight: 32,
                          minWidth: 40
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: BrandColor.black69
                          )
                        ),
                        alignment: Alignment.center,
                        child:  Builder(
                          builder: (context) {
                            String fullAddress="${geocoding!.homeNumber} ${geocoding!.street.isNotEmpty?geocoding!.street+",":""} ${geocoding!.city.isNotEmpty?geocoding!.city+",":""} ${geocoding!.stateShort.isNotEmpty?geocoding!.stateShort+",":""} ${geocoding!.country}";
                            return Text(
                                      fullAddress,
                                      style: TextStyle(
                                        fontFamily: BrandFontFamily.platform,
                                        fontSize: 14,
                                        color: BrandColor.black69,
                                        fontWeight: FontWeight.w400
                                      ),
                                    );
                          }
                        )
                      );
                    }
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/google_map_ui.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/geocoding.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/core/tools/debounce.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/to_input_scene.dart';


class SearchFromMap extends StatefulWidget {
  const SearchFromMap({super.key});

  @override
  State<SearchFromMap> createState() => _SearchFromMapState();
}

class _SearchFromMapState extends State<SearchFromMap> {

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
    final state= context.read<SearchRideBloc>().state;
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor:Colors.white,
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
                  mapParams: state.fromMapParams,
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
                          stateShort: geocoding!.stateShort,
                          street: geocoding!.street,
                          homeNumber: geocoding!.homeNumber,
                          longitude: currentLon,
                          latitude: currentLat,
                          departureTime: DateTime.now()
                        );
                        context.read<SearchRideBloc>().add(SearchRideSetFromLocation(location: location));
                        inspect(location);
                        setState(() {
                          isLockedButton=false;
                        });
                        context.goNamed(RoutesName.main);
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => ToInputScene(),));
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
                                child: CircularProgressIndicator(color: BrandColor.black,)),
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
                            color: BrandColor.black
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
                                        color: BrandColor.black,
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
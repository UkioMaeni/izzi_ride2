import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';

class GoogleMapUi extends StatefulWidget {
  final MapParams mapParams;
  const GoogleMapUi({super.key,required this.mapParams});

  @override
  State<GoogleMapUi> createState() => _GoogleMapUiState();
}

class _GoogleMapUiState extends State<GoogleMapUi> {

  Set<Marker> _markers={
    
  };

  late CameraPosition initial;
  final Completer<GoogleMapController> _completer=Completer<GoogleMapController>();
  late GoogleMapController _mapController;
  late double currentLon = 0;
  late double currentLat = 0;
  @override
  void initState() {
    currentLon=widget.mapParams.lon;
    currentLat=widget.mapParams.lat;
   initial= CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(currentLat, currentLon),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414
    );
    super.initState();
  }

  


  @override
  Widget build(BuildContext context) {
    return GoogleMap(
          markers:_markers ,
          myLocationButtonEnabled: false,
          initialCameraPosition: initial,
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
            _completer.complete(controller);
            _mapController=await _completer.future;
          },
          onCameraMove: (position)async {
            //final bounds = await _controller.getLatLng(const ScreenCoordinate(x: 0, y: 0));
            LatLng center=position.target;
            setState(() {
              currentLat = center.latitude;
              currentLon = center.longitude;
            });
          },
          onCameraIdle: () async {
            
            //getResult(latitudeRide,longitudeRide);
           
          },

        );
  }
}
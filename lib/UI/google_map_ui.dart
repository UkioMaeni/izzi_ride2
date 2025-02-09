import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:uuid/uuid.dart';
class GoogleMapUi extends StatefulWidget {
  final MapParams mapParams;
  final Function(double lat,double lon) onCameraIdle;
  const GoogleMapUi({super.key,required this.mapParams,required this.onCameraIdle});

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
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    print(widget.mapParams.lat);
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
  
  String markerId="";
  updateMapVisualWithNewGeo(LatLng argument)async{
    widget.onCameraIdle(currentLat,currentLon);
    ByteData data = await rootBundle.load("assets/image/icons/geo_icon.png");
     LatLng center=argument;
            setState(() {
              currentLat = center.latitude;
              currentLon = center.longitude;
            });
            
            _markers.removeWhere((element) => element.markerId==MarkerId(markerId),);
            String v4= Uuid().v4();
            _markers.add(
                Marker(
                  markerId: MarkerId(v4),
                  position: LatLng(currentLat,currentLon),
                  icon:  BytesMapBitmap(data.buffer.asUint8List())
                )
              );
            markerId=v4;
            
  }


  @override
  Widget build(BuildContext context) {
    
    return GoogleMap(
          buildingsEnabled: true,
          compassEnabled: false,
          indoorViewEnabled: false,
          
          zoomControlsEnabled: false,
          
          markers:_markers,
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
            print('COMPLETED');
            _completer.complete(controller);
            _mapController=await _completer.future;
            
            updateMapVisualWithNewGeo(LatLng(widget.mapParams.lat, widget.mapParams.lon));
          },
          onCameraMove: (position)async {
            //final bounds = await _controller.getLatLng(const ScreenCoordinate(x: 0, y: 0));
            
          },
          onTap: updateMapVisualWithNewGeo,

          onCameraIdle: () async {
          },

        );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/rides_bloc/rides_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/enum_ride_booked_status.dart';
import 'package:izzi_ride_2/core/models/enum_ride_status.dart';
import 'package:izzi_ride_2/core/models/enum_role.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/preview_create/components/preview_data.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/preview_create/components/preview_location.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/preview_create/components/preview_time.dart';

class PreviewCreate extends StatefulWidget {
  const PreviewCreate({super.key});

  @override
  State<PreviewCreate> createState() => _PreviewCreateState();
}

class _PreviewCreateState extends State<PreviewCreate> {


  Future<void> createRide()async{

    final createRideBlocState = context.read<CreateRideBloc>().state;
    final ridesBloc = context.read<RidesBloc>();
    Location fromLocation= createRideBlocState.fromLocation;
    Location toLocation= createRideBlocState.toLocation;
    DateTime startDate =DateTime(
      createRideBlocState.date.year,
      createRideBlocState.date.month,
      createRideBlocState.date.day,
      createRideBlocState.time.hour,
      createRideBlocState.time.minute,
    );
    
    fromLocation.departureTime=startDate;
    fromLocation.sortId=1;
    toLocation.sortId=2;
    final ride=RideModel(
      clientAutoId: createRideBlocState.car.carId,
      comment: createRideBlocState.comment,
      price: createRideBlocState.price.toDouble(),
      numberOfSeats: createRideBlocState.car.seats,
      additional: createRideBlocState.additional,
      locations: [fromLocation,createRideBlocState.toLocation],
      autoInstant: createRideBlocState.autoInstant,
      paymaentMetodId: createRideBlocState.paymaentMetodId,
      rideType: createRideBlocState.rideType,
      driverNickname: "",
      driverName: "",
      driverRate: 0,
      freeSeats: 0,
      orderId: 0,
      rideStatus: EnumRideStatus.error,
      rideBookedStatus: EnumRideBookedStatus.error,
      role: Role.error,
      totalSeats: 0,
      date: DateTime.now(),
      endLocationName: "",
      startLocationName: "",
      travalers: [],
      creatorId: -1,
      carName: ""
    );
    final result = await UserHttp.I.createUserRide(ride);
    if(result is CustomResponse<bool>){
      ridesBloc.add(RidesGetUserRides());
      context.goNamed(RoutesName.createDone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
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
                  SizedBox(height: 44,),
                   Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(),
                          Text(
                            "Ride information",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 32,
                              color: BrandColor.black69,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          SizedBox(height: 32,),
                          PreviewLocation(),
                          //R.SVG.DottedLine,
                          PreviewData(),
                          PreviewTime(),
                          SizedBox(height: 24,),
                          UIButton(
                            label: "Done",
                            onFuture: createRide,
                          ),
                          SizedBox(height: 44,),
                        ],
                      ),
                    
                  ),
                  
                ],
              ),
            ),
          
        
      ),
    );
  }
}
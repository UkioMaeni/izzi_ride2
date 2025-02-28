import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/trip_card/trip_card.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/core/http/order_http.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/extensions/date_time_extension.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {


  List<RideModel> rides=[];

  bool loading=true;


  Future<void> searchTrips()async{
    setState(() {
      loading=true;
    });
    final fromLocation=context.read<SearchRideBloc>().state.fromLocation;
    final toLocation=context.read<SearchRideBloc>().state.toLocation;
    int? fromCityId= await OrderHttp.I.getCityId(fromLocation); 
    int? toCityId=await OrderHttp.I.getCityId(toLocation); 
    log(fromCityId.toString());
    log(toCityId.toString());
    if(fromCityId==null||toCityId==null){
      print("ERROR");
      //TODO: плашка с ошибкой
      return;
    }
    final personCount=context.read<SearchRideBloc>().state.personCount;
    final searchBlocState=context.read<SearchRideBloc>().state;
    final date= DateTime(
      searchBlocState.date.year,
      searchBlocState.date.month,
      searchBlocState.date.day,
      searchBlocState.time.hour,
      searchBlocState.time.minute,
    );
    final rideType=context.read<SearchRideBloc>().state.rideType.name;
   log("START S");
    final result= await OrderHttp.I.searchOrder(fromCityId,toCityId,personCount,date,rideType);
    if(result is CustomResponse<List<RideModel>>){
      setState(() {
        rides=result.data;
      });
    }
    log("STOP S");
    setState(() {
      loading=false;
    });
  }
  @override
  void initState() {
    searchTrips();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Builder(
        builder: (context) {
          if(loading){
            return TripCard.shimmer();
          }
          print(rides.length);
          return ListView.builder(
            itemCount: rides.length,
            itemBuilder: (context, index) {
              final trip=rides[index];
              return GestureDetector(
                onTap: () {
                  context.pushNamed(RoutesName.orderFullInfo,extra: trip.orderId);
                },
                child: TripCard.view(trip: rides[index])
              );
            },
          );
        },
      ),
    );
  }
}
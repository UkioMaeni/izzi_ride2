import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/UI/trip_card/trip_card.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/core/http/order_http.dart';
import 'package:izzi_ride_2/extensions/date_time_extension.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {


  Future<void> searchTrips()async{
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
    final date=context.read<SearchRideBloc>().state.date;
   log("START S");
    await OrderHttp.I.searchOrder(fromCityId,toCityId,personCount,date);
    log("STOP S");
  }
  @override
  void initState() {
    searchTrips();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Builder(
                builder: (context) {
                  return TripCard.shimmer();
                },
              ),
            ),
    );
  }
}
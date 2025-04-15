import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';

part 'rides_state.dart';
part 'rides_event.dart';

class RidesBloc extends Bloc<RidesEvent,RidesFullState>{
  RidesBloc():super(RidesFullState.empty()){
    on<RidesGetUserRides>((event, emit)async{
      emit(state.copyWith(requsted: true));
      final resultRides = await UserHttp.I.getUserRides();
      final resultTGrips =  await UserHttp.I.getMyTrips();
      List<RideModel> newRides=[];
      if(resultRides is CustomResponse<List<RideModel>>){
        newRides.addAll(resultRides.data);
      }else{
        
      }
      if(resultTGrips is CustomResponse<List<RideModel>>){
        newRides.addAll(resultTGrips.data);
      }else{
        
      }
      emit(state.copyWith(rides: newRides));
      emit(state.copyWith(requsted: false));
    });
    on<RidesUpdateRide>((event, emit)async{
      log("RidesUpdateRide");
      if(state.rides==null) return;
      List<RideModel>  rides = state.rides!;
      int? indexToUpdate;
      for(var i = 0; i < rides.length; i++){
        if(rides[i].orderId == event.orderId){
          indexToUpdate = i;
          break;
        }
      }
      if(indexToUpdate == null){
        return;
      }
      final result = await UserHttp.I.getUserRides(id:event.orderId);
      if(result is CustomResponse<List<RideModel>>){
        log("new data ride");
        
        if(result.data.isEmpty){
          log("NUUUL");
          return;
        }
        log(result.data[0].travalers.toString());
        rides[indexToUpdate] = result.data[0];
        inspect(rides);
        emit(state.copyWith(rides: rides));
      }
    });
    on<RidesEditStatusTravalerInRide>((event, emit)async{
      log("RidesEditStatusTravalerInRide");
      if(state.rides==null) return;
      List<RideModel>  rides = state.rides!;
      int? indexToUpdate;
      for(var i = 0; i < rides.length; i++){
        if(rides[i].orderId == event.orderId){
          indexToUpdate = i;
          break;
        }
      }
      if(indexToUpdate == null){
        return;
      }
      final result = await UserHttp.I.getUserRides(id:event.orderId);
      if(result is CustomResponse<List<RideModel>>){
        log("new data ride");
        
        if(result.data.isEmpty){
          log("NUUUL");
          return;
        }
        log(result.data[0].travalers.toString());
        rides[indexToUpdate] = result.data[0];
        inspect(rides);
        emit(state.copyWith(rides: rides));
      }
    });
    
  }
  
}
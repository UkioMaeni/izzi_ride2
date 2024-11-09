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

enum SceneType{
  from,
  to
}

class RidesBloc extends Bloc<RidesEvent,RidesFullState>{
  RidesBloc():super(RidesFullState.empty()){
    on<RidesGetUserRides>((event, emit)async{
      final result = await UserHttp.I.getUserRides();
      if(result is CustomResponse<List<RideModel>>){
        emit(state.copyWith(rides: result.data));
      }
      
    });
    
  }
  
}
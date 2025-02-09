import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/response.dart';

part 'car_state.dart';
part 'car_event.dart';


class CarBloc extends Bloc<CarEvent,CarFullState>{
  CarBloc():super(CarFullState.empty()){
    on<CarGetInUser>((event, emit)async{
      emit(state.copyWith(requsted: true));
      final result = await UserHttp.Instance.getUserCar();
      if(result is CustomResponse<List<CarItem>>){
        emit(state.copyWith(cars: result.data));
      }
      emit(state.copyWith(requsted: false));
      //emit(state.copyWith(scene: event.newScene));
    });
    
  }
  
}
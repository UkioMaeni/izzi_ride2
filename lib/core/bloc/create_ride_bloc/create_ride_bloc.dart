import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/enum_ride_type.dart';
import 'package:izzi_ride_2/core/models/enum_scene_type.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';

part 'create_ride_state.dart';
part 'create_ride_event.dart';



class CreateRideBloc extends Bloc<CreateRideEvent,CreateRideFullState>{
  CreateRideBloc():super(CreateRideFullState.empty()){
    on<CreateRideEditScene>((event, emit)async{
      emit(state.copyWith(scene: event.newScene));
    });
    on<CreateRideSetMapParams>((event, emit)async{
      if(event.type==SceneType.from){
        emit(state.copyWith(fromMapParams: event.mapParams));
      }else{
        emit(state.copyWith(toMapParams: event.mapParams));
      }
    });
    on<CreateRideSetFromLocation>((event, emit)async{
      emit(state.copyWith(fromLocation: event.location));
    });
    on<CreateRideSetToLocation>((event, emit)async{
      emit(state.copyWith(toLocation: event.location));
    });
    on<CreateRideEditAdditional>((event, emit)async{
      emit(state.copyWith(additional: event.additional));
    });
    on<CreateRideEditComment>((event, emit)async{
      emit(state.copyWith(comment: event.comment));
    });
    on<CreateRideEditPrice>((event, emit)async{
      emit(state.copyWith(price: event.price));
    });
    on<CreateRideEditPaymentMethod>((event, emit)async{
      emit(state.copyWith(paymaentMetodId: event.paymaentMetodId));
    });
    
    on<CreateRideEditDate>((event, emit)async{
      emit(state.copyWith(date: event.date));
    });
    on<CreateRideEditTime>((event, emit)async{
      emit(state.copyWith(time: event.time));
    });
    on<CreateRideSetCar>((event, emit)async{
      emit(state.copyWith(car: event.carItem));
    });
    on<CreateRideSetAutoInstant>((event, emit)async{
      emit(state.copyWith(autoInstant: event.autoInstant));
    });
    on<CreateRideEditRideType>((event, emit)async{
      emit(state.copyWith(rideType: event.rideType));
    });
    on<CreateRide_RESET_DATA>((event, emit)async{
      emit(CreateRideFullState.empty());
    });
    
  }
  
}
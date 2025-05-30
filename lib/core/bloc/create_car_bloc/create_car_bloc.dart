import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/color_library.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/search_car_brand_and_model.dart';

part 'create_car_state.dart';
part 'create_car_event.dart';

class CreateCarBloc extends Bloc<CreateCarEvent,CreateCarState>{
  CreateCarBloc():super(CreateCarState.empty()){
    on<CreateCarSelectBrand>((event, emit)async{
      emit(state.copyWith(brand: event.brand));
    });
    on<CreateCarSelectModel>((event, emit)async{
      emit(state.copyWith(model: event.model));
    });
    on<CreateCarSelectSeats>((event, emit)async{
      emit(state.copyWith(seats: event.seats));
    });
    on<CreateCarSelectColorCar>((event, emit)async{
      emit(state.copyWith(colorCar: event.colorCar));
    });
    on<CreateCarSelectCarNumber>((event, emit)async{
      emit(state.copyWith(carNumber: event.carNumber));
    });
    on<CreateCarSelectCarYear>((event, emit)async{
      emit(state.copyWith(carYear: event.carYear));
    });
    on<CreateCarAddPhotos>((event, emit)async{
      emit(state.copyWith(carPotos: event.carPhotos));
    });
    on<CreateCarAddPhotosUrl>((event, emit)async{
      emit(state.copyWith(carPotosUrls: event.carPhotosUrls));
    });
    
    on<CreateCar_RESET_DATA>((event, emit)async{
      emit(CreateCarState.empty());
    });
    
    
  }
  
}
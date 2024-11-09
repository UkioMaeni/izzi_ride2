import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/search_car_brand_and_model.dart';

part 'create_car_state.dart';
part 'create_car_event.dart';

enum SceneType{
  from,
  to
}

class CreateCarBloc extends Bloc<CreateCarEvent,CreateCarState>{
  CreateCarBloc():super(CreateCarState.empty()){
    on<CreateCarSelectBrand>((event, emit)async{
      emit(state.copyWith(brand: event.brand));
    });
    
  }
  
}
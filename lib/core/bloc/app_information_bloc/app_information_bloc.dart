import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/response.dart';

part 'app_information_state.dart';
part 'app_information_event.dart';


class AppInformationBloc extends Bloc<AppInformationEvent,AppInformationState>{
  AppInformationBloc():super(AppInformationState.empty()){
    on<AppInformationSetRequridedLoadServices>((event, emit)async{
      emit(state.copyWith(isGetLoadedRequiredServices:event.isRequired));
    });
    on<AppInformationSetIalTabPage>((event, emit)async{
      emit(state.copyWith(initialTabPage:event.page));
    });
    
  }
  
}
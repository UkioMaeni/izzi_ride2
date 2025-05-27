import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/user_model.dart';

part 'user_me_state.dart';
part 'user_me_event.dart';


class UserMeBloc extends Bloc<UserMeEvent,UserMeState>{
  UserMeBloc():super(UserMeState.empty()){
    on<UserMeGetMeInfo>((event, emit)async{
      emit(state.copyWith(requsted: true));
      final result = await UserHttp.Instance.getMeInfo();
      if(result is CustomResponse<UserModel>){
        emit(state.copyWith(me: result.data));
      }else{
        emit(state.copyWith(hasUnhundledError: true));
      }
      emit(state.copyWith(requsted: false));
    });
    on<UserMe_RESET_DATA>((event, emit){
      emit(UserMeState.empty());
    });
    
  }
  
}
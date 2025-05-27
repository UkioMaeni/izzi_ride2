import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/pages/photo_scene/photo_scene.dart';

part 'photo_add_state.dart';
part 'photo_add_event.dart';


class PhotoAddBloc extends Bloc<PhotoAddEvent,PhotoAddState>{
  PhotoAddBloc():super(PhotoAddState.empty()){
    on<PhotoAddSetProfileTempPhoto>((event, emit)async{
      state.photoTempUser=event.file;
      emit(state);
    });
    on<PhotoAddSetCarTempPhoto>((event, emit)async{
      state.photoTempCar=event.file;
      emit(state);
    });
    on<PhotoAddSetphotoSceneType>((event, emit)async{
      emit(state.copyWith(photoSceneType: event.photoSceneType));
    });
    on<PhotoAdd_RESET_DATA>((event, emit)async{
      emit(PhotoAddState.empty());
    });
    
  }
  
}
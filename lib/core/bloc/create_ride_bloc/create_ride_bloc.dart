import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';

part 'create_ride_state.dart';
part 'create_ride_event.dart';

enum SceneType{
  from,
  to
}

class CreateRideBloc extends Bloc<CreateRideEvent,CreateRideFullState>{
  CreateRideBloc():super(CreateRideFullState.empty()){
    on<CreateRideEditScene>((event, emit)async{
      emit(state.copyWith(scene: event.newScene));
    });
    on<CreateRideNextScene>((event, emit)async{
      emit(state.copyWith(scene: state.allScenes[state.indexCurrentScene+1]));
    });
    on<CreateRideBackScene>((event, emit)async{
      emit(state.copyWith(scene: state.allScenes[state.indexCurrentScene-1]));
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
  }
  
}
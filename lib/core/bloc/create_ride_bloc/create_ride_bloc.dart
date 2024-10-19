import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';

part 'create_ride_state.dart';
part 'create_ride_event.dart';

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
      emit(state.copyWith(mapParams: event.mapParams));
    });
  }
  
}
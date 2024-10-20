part of 'create_ride_bloc.dart';




class CreateRideFullState {
  
  final Scene scene;

  List<Scene> get allScenes => [
    Scene.initial,
    Scene.fromInput,
    Scene.fromMap,
    Scene.toInput,
    Scene.toMap,
    Scene.selectDate,
    Scene.selectTime,
    Scene.selectCar,
    Scene.additional
  ]; 
  int get indexCurrentScene => allScenes.indexWhere((element) => element==scene,);

  final MapParams fromMapParams;
  final MapParams toMapParams;
  final String code;
  final Location fromLocation;
  final Location toLocation;
  const CreateRideFullState({
    required this.scene,
    required this.fromMapParams,
    required this.toMapParams,
    required this.code,
    required this.fromLocation,
    required this.toLocation
  });

  static  CreateRideFullState empty(){
    return CreateRideFullState(
      scene: Scene.initial,
      fromMapParams: MapParams.empty(),
      toMapParams: MapParams.empty(),
      code: "",
      fromLocation: Location.empty(),
      toLocation: Location.empty()
    );
  }
  copyWith({
      Scene? scene,
      MapParams? fromMapParams,
      MapParams? toMapParams,
      String? code,
      Location? fromLocation,
      Location? toLocation,
    }){
    return CreateRideFullState(
      scene: scene??this.scene,
      fromMapParams: fromMapParams??this.fromMapParams,
      toMapParams: toMapParams??this.toMapParams,
      code: code??this.code,
      fromLocation: fromLocation??this.fromLocation,
      toLocation: toLocation??this.toLocation
    );
  }

}
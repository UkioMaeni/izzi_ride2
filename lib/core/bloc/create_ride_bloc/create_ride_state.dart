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

  final MapParams mapParams;
  final String code;
  final String? codeError;
  const CreateRideFullState({
    required this.scene,
    required this.mapParams,
    required this.code,
    required this.codeError
  });

  static  CreateRideFullState empty(){
    return CreateRideFullState(
      scene: Scene.initial,
      mapParams: MapParams.empty(),
      code: "",
      codeError: null
    );
  }
  copyWith({
      Scene? scene,
      MapParams? mapParams,
      String? code,
      String? codeError,
    }){
    return CreateRideFullState(
      scene: scene??this.scene,
      mapParams: mapParams??this.mapParams,
      code: code??this.code,
      codeError: codeError??this.codeError
    );
  }

}
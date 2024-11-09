part of 'rides_bloc.dart';




class RidesFullState {
  
  List<RideModel>? rides;
  bool requsted;
  RidesFullState({
    required this.rides,
    required this.requsted
  });

  static  RidesFullState empty(){
    return RidesFullState(
      rides: null,
      requsted: false
    );
  }
  copyWith({
      List<RideModel>? rides,
      bool? requsted,
    }){
    return RidesFullState(
      rides: rides??this.rides,
      requsted: requsted??this.requsted
    );
  }

}
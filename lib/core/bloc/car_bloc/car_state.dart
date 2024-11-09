part of 'car_bloc.dart';




class CarFullState {
  
  List<CarItem>? cars;
  bool requsted;
  CarFullState({
    required this.cars,
    required this.requsted
  });

  static  CarFullState empty(){
    return CarFullState(
      cars: null,
      requsted: false
    );
  }
  copyWith({
      List<CarItem>? cars,
      bool? requsted,
    }){
    return CarFullState(
      cars: cars??this.cars,
      requsted: requsted??this.requsted
    );
  }

}
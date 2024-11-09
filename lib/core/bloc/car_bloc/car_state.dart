part of 'car_bloc.dart';




class CarFullState {
  
  List<CarItem>? cars;
  CarFullState({
    required this.cars
  });

  static  CarFullState empty(){
    return CarFullState(
      cars: null
    );
  }
  copyWith({
      List<CarItem>? cars,
    }){
    return CarFullState(
      cars: cars??this.cars,
    );
  }

}
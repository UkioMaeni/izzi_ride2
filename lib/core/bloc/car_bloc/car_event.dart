part of 'car_bloc.dart';

abstract class CarEvent{
  const CarEvent();
}

enum Scene{
  initial,
  fromInput,
  fromMap,
  toInput,
  toMap,
  selectDate,
  selectTime,
  selectCar,
  additional
}



class CarGetInUser extends CarEvent{
  const CarGetInUser();
}

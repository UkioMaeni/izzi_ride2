part of 'create_car_bloc.dart';

abstract class CreateCarEvent{
  const CreateCarEvent();
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



class CreateCarSelectBrand extends CreateCarEvent{
  final SearchCarBrandAndModel brand;
  const CreateCarSelectBrand({required this.brand});
}

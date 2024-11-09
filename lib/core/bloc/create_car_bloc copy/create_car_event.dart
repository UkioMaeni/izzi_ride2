part of 'create_car_bloc.dart';

abstract class CreateCarEvent{
  const CreateCarEvent();
}


class CreateCarSelectBrand extends CreateCarEvent{
  final SearchCarBrandAndModel brand;
  const CreateCarSelectBrand({required this.brand});
}

class CreateCarSelectModel extends CreateCarEvent{
  final SearchCarBrandAndModel model;
  const CreateCarSelectModel({required this.model});
}

class CreateCarSelectSeats extends CreateCarEvent{
  final int seats;
  const CreateCarSelectSeats({required this.seats});
}

class CreateCarSelectColorCar extends CreateCarEvent{
  final ColorCar colorCar;
  const CreateCarSelectColorCar({required this.colorCar});
}

class CreateCarSelectCarNumber extends CreateCarEvent{
  final String carNumber;
  const CreateCarSelectCarNumber({required this.carNumber});
}

class CreateCarSelectCarYear extends CreateCarEvent{
  final String carYear;
  const CreateCarSelectCarYear({required this.carYear});
}

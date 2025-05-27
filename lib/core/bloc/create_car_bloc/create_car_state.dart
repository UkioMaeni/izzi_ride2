part of 'create_car_bloc.dart';




class CreateCarState {
  
  SearchCarBrandAndModel brand;
  SearchCarBrandAndModel model;
  int seats;
  ColorCar colorCar;
  String carNumber;
  String carYear;

 String get fullCarName =>  "${brand.name} ${model.name}";

  CreateCarState({
    required this.brand,
    required this.model,
    required this.seats,
    required this.colorCar,
    required this.carNumber,
    required this.carYear,
  });

  static  CreateCarState empty(){
    return CreateCarState(
      brand: SearchCarBrandAndModel.empty(),
      model: SearchCarBrandAndModel.empty(),
      seats: 1,
      colorCar: ColorCar(stringColor: "Black"),
      carNumber: "",
      carYear: "",
    );
  }
  copyWith({
      SearchCarBrandAndModel? brand,
      SearchCarBrandAndModel? model,
      int? seats,
      ColorCar? colorCar,
      String? carNumber,
      String? carYear,
    }){
    return CreateCarState(
      brand: brand??this.brand,
      model: model??this.model,
      seats: seats??this.seats,
      colorCar: colorCar??this.colorCar,
      carNumber: carNumber??this.carNumber,
      carYear: carYear??this.carYear,
    );
  }

}
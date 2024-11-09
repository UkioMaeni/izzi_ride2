part of 'create_car_bloc.dart';




class CreateCarState {
  
  SearchCarBrandAndModel brand;
  SearchCarBrandAndModel model;
  CreateCarState({
    required this.brand,
    required this.model
  });

  static  CreateCarState empty(){
    return CreateCarState(
      brand: SearchCarBrandAndModel.empty(),
      model: SearchCarBrandAndModel.empty()
    );
  }
  copyWith({
      SearchCarBrandAndModel? brand,
      SearchCarBrandAndModel? model,
    }){
    return CreateCarState(
      brand: brand??this.brand,
      model: model??this.model,
    );
  }

}
part of 'create_ride_bloc.dart';




class CreateRideFullState {
  
  final MapParams fromMapParams;
  final MapParams toMapParams;
  final String code;
  final Location fromLocation;
  final Location toLocation;
  final CarItem car;
  DateTime date;
  TimeOfDay time;
  Additional additional=Additional();
  String comment="";
  int paymaentMetodId;
  int price;
  bool autoInstant;
  CreateRideFullState({
    required this.fromMapParams,
    required this.toMapParams,
    required this.date,
    required this.time,
    required this.code,
    required this.fromLocation,
    required this.toLocation,
    required this.car,
    required this.paymaentMetodId,
    required this.price,
    required this.autoInstant
  });

  static  CreateRideFullState empty(){
    return CreateRideFullState(
      fromMapParams: MapParams.empty(),
      toMapParams: MapParams.empty(),
      date: DateTime.now(),
      time: TimeOfDay.now(),
      code: "",
      fromLocation: Location.empty(),
      toLocation: Location.empty(), 
      car: CarItem(carId: 0, brand: "", model: "", color: "", seats: 0, year: ""),
      price: 5,
      paymaentMetodId: 1,
      autoInstant: false
    );
  }
  copyWith({
      Scene? scene,
      MapParams? fromMapParams,
      MapParams? toMapParams,
      DateTime? date,
      TimeOfDay? time,
      String? code,
      Location? fromLocation,
      Location? toLocation,
      CarItem? car,
      Additional? additional,
      String? comment,
      int? price,
      int? paymaentMetodId,
      bool? autoInstant,
    }){
    return CreateRideFullState(
      fromMapParams: fromMapParams??this.fromMapParams,
      toMapParams: toMapParams??this.toMapParams,
      date: date??this.date,
      time: time??this.time,
      code: code??this.code,
      fromLocation: fromLocation??this.fromLocation,
      toLocation: toLocation??this.toLocation,
      car: car??this.car,
      price: price??this.price,
      paymaentMetodId: paymaentMetodId??this.paymaentMetodId,
      autoInstant: autoInstant??this.autoInstant,
    )
    ..additional=additional??this.additional
    ..comment=comment??this.comment;
  }

}
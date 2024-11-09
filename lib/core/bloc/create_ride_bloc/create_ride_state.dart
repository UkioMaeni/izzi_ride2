part of 'create_ride_bloc.dart';




class CreateRideFullState {
  
  final MapParams fromMapParams;
  final MapParams toMapParams;
  final String code;
  final Location fromLocation;
  final Location toLocation;
  DateTime date;
  TimeOfDay time;
  Additional additional=Additional();
  String comment="";
  int price;
  CreateRideFullState({
    required this.fromMapParams,
    required this.toMapParams,
    required this.date,
    required this.time,
    required this.code,
    required this.fromLocation,
    required this.toLocation,
    required this.price
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
      price: 5
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
      Additional? additional,
      String? comment,
      int? price,
    }){
    return CreateRideFullState(
      fromMapParams: fromMapParams??this.fromMapParams,
      toMapParams: toMapParams??this.toMapParams,
      date: date??this.date,
      time: time??this.time,
      code: code??this.code,
      fromLocation: fromLocation??this.fromLocation,
      toLocation: toLocation??this.toLocation,
      price: price??this.price
    )
    ..additional=additional??this.additional
    ..comment=comment??this.comment;
  }

}
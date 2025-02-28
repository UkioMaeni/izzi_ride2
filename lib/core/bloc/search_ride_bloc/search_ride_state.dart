part of 'search_ride_bloc.dart';




class SearchRideState {
  
  final EnumRideType rideType;
  final MapParams toMapParams;
  final MapParams fromMapParams;
  final String code;
  final Location fromLocation;
  final Location toLocation;
  final CarItem car;
  int personCount;
  Map<ECategory,SearchFilter> filters={};
  bool filtersEdited;
  DateTime date;
  TimeOfDay time;
  Additional additional=Additional();
  String comment="";
  int paymaentMetodId;
  int price;
  bool autoInstant;
  SearchRideState({
    required this.rideType,
    required this.toMapParams,
    required this.fromMapParams,
    required this.date,
    required this.time,
    required this.code,
    required this.fromLocation,
    required this.toLocation,
    required this.car,
    required this.paymaentMetodId,
    required this.price,
    required this.autoInstant,
    required this.personCount,
    required this.filtersEdited
  });

  static  SearchRideState empty(){
    return SearchRideState(
      rideType: EnumRideType.client,
      fromMapParams: MapParams.empty(),
      toMapParams: MapParams.empty(),
      date: DateTime.now(),
      time: TimeOfDay.now(),
      code: "",
      fromLocation: Location.empty(),
      toLocation: Location.empty(), 
      car: CarItem(carId: 0, brand: "", model: "", color: "", seats: 0, year: "",number: ""),
      price: 5,
      paymaentMetodId: 1,
      autoInstant: false,
      personCount: 1,
      filtersEdited: false
    );
  }
  copyWith({
      Scene? scene,
      EnumRideType? rideType,
      MapParams? toMapParams,
      MapParams? fromMapParams,
      DateTime? date,
      TimeOfDay? time,
      int? personCount,
      Map<ECategory,SearchFilter>? filters,
      bool? filtersEdited,
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
    return SearchRideState(
      rideType: rideType??this.rideType,
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
      personCount: personCount??this.personCount,
      filtersEdited: filtersEdited??this.filtersEdited
    )
    ..filters=filters??this.filters;
  }

}
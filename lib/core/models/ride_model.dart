import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/enum_ride_booked_status.dart';
import 'package:izzi_ride_2/core/models/enum_ride_status.dart';
import 'package:izzi_ride_2/core/models/enum_ride_type.dart';
import 'package:izzi_ride_2/core/models/enum_role.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/travaler_model.dart';
import 'package:izzi_ride_2/extensions/date_time_extension.dart';

class RideModel{
  int orderId;
  int clientAutoId;
  double price;
  int paymaentMetodId;
  int numberOfSeats;
  String comment; 
  Additional additional;
  List<Location> locations;
  List<TravalerModel> travalers;
  EnumRideType rideType;
  double driverRate;
  String driverNickname;
  EnumRideStatus rideStatus;
  EnumRideBookedStatus rideBookedStatus;
  int totalSeats;
  int freeSeats;
  DateTime date;
  String startLocationName;
  String endLocationName;
  bool autoInstant;
  String carName;
  CarItem? carInfo;
  Role role;
  int creatorId;
  RideModel({
    required this.orderId,
    required this.clientAutoId,
    required this.comment,
    required this.price,
    required this.paymaentMetodId,
    required this.numberOfSeats,
    required this.additional,
    required this.locations,
    required this.travalers,
    required this.driverRate,
    required this.driverNickname,
    required this.rideStatus,
    required this.rideBookedStatus,
    required this.totalSeats,
    required this.freeSeats,
    required this.date,
    required this.startLocationName,
    required this.endLocationName,
    required this.autoInstant,
    required this.rideType,
    required this.carName,
    required this.role,
    this.carInfo,
    required this.creatorId
  });
  static RideModel nullable(){
    return RideModel(
      orderId: 0,
      additional: Additional(),
      clientAutoId: 0,
      comment: "",
      locations: [],
      numberOfSeats: 0,
      price: 0,
      paymaentMetodId: 0,
      driverRate: 0,
      driverNickname: "",
      freeSeats: 0,
      rideStatus: EnumRideStatus.error,
      rideBookedStatus: EnumRideBookedStatus.error,
      role: Role.error,
      totalSeats: 0,
      date: DateTime.now(),
      startLocationName: "",
      endLocationName: "",
      autoInstant: false,
      travalers: [],
      rideType: EnumRideType.client,
      carName: "",
      creatorId: 0
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "client_auto_id":clientAutoId,
      "ride_info":additional.toJson(),
      "payment_method_id":paymaentMetodId,
      "order_type":rideType.name,
      "auto_accept":autoInstant,
      "payment_info":{"type":1 },
      "departure_time":date.toIZZIRIDEFORMAT(),
      "locations":locations.map((loc) =>loc.toJson()).toList()
    };
  }
}
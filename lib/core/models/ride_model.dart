import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/location.dart';

class RideModel{
  int orderId;
  int clientAutoId;
  double price;
  int numberOfSeats;
  String comment; 
  Additional additional;
  List<Location> locations;
  double driverRate;
  String driverNickname;
  String rideStatus;
  int totalSeats;
  int freeSeats;
  DateTime date;
  String startLocationName;
  String endLocationName;
  RideModel({
    required this.orderId,
    required this.clientAutoId,
    required this.comment,
    required this.price,
    required this.numberOfSeats,
    required this.additional,
    required this.locations,
    required this.driverRate,
    required this.driverNickname,
    required this.rideStatus,
    required this.totalSeats,
    required this.freeSeats,
    required this.date,
    required this.startLocationName,
    required this.endLocationName,
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
      driverRate: 0,
      driverNickname: "",
      freeSeats: 0,
      rideStatus: "",
      totalSeats: 0,
      date: DateTime.now(),
      startLocationName: "",
      endLocationName: ""
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "client_auto_id":clientAutoId,
      "ride_info":additional.toJson(),
      "payment_info":{"type":1 },
      "locations":locations.map((loc) =>loc.toJson()).toList()
    };
  }
}
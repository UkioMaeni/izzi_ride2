import 'package:izzi_ride_2/core/models/additional.dart';
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
  double driverRate;
  String driverNickname;
  String rideStatus;
  int totalSeats;
  int freeSeats;
  DateTime date;
  String startLocationName;
  String endLocationName;
  bool autoInstant;
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
    required this.totalSeats,
    required this.freeSeats,
    required this.date,
    required this.startLocationName,
    required this.endLocationName,
    required this.autoInstant,
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
      rideStatus: "",
      totalSeats: 0,
      date: DateTime.now(),
      startLocationName: "",
      endLocationName: "",
      autoInstant: false,
      travalers: []
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "client_auto_id":clientAutoId,
      "ride_info":additional.toJson(),
      "payment_method_id":paymaentMetodId,
      "auto_accept":autoInstant,
      "payment_info":{"type":1 },
      "date":date.toIZZIRIDEFORMAT(),
      "locations":locations.map((loc) =>loc.toJson()).toList()
    };
  }
}
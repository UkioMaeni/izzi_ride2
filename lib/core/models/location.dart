import 'package:intl/intl.dart';

class Location{
  String city;
  String state;
  String stateShort;
  String homeNumber;
  String street;
  int sortId;
  bool pickUp;
  String location;
  double longitude;
  double latitude;
  DateTime departureTime;
   Location({
    required this.city,
    required this.state,
    required this.stateShort,
    required this.street,
    required this.homeNumber,
    required this.sortId,
    required this.pickUp,
    required this.location,
    required this.longitude,
    required this.latitude,
    required this.departureTime
   });

    String get  fullAddress => 
      (homeNumber.isNotEmpty?homeNumber+", ":"") +
      (street.isNotEmpty?street+", ":"")+
      (city.isNotEmpty?city+", ":"")+
      (state.isNotEmpty?state+",":"");

  static Location empty(){
    return Location(
      city: "", 
      state: "", 
      stateShort: "",
      street: "",
      homeNumber: "",
      sortId: -1, 
      pickUp: false, 
      location: "", 
      longitude: 0, 
      latitude: 0, 
      departureTime: DateTime.now()
    );
  }
   Map<String,dynamic> toJson(){
    return {
      "city":city,
      "state":state,
      "sort_id":sortId,
      "pick_up":pickUp,
      "location":location,
      "longitude":longitude,
      "latitude":latitude,
      "departure_time":dateConverter()
    };
   }
   String dateConverter(){
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ssZ');
    String formattedTime = formatter.format(departureTime);
    String tzName(Duration offset) {
      String hours = offset.inHours.abs().toString().padLeft(2, '0');
      String minutes = (offset.inMinutes % 60).abs().toString().padLeft(2, '0');
      String sign = offset.isNegative ? '-' : '+';

      return '$sign$hours:$minutes';
    }
    formattedTime += tzName(departureTime.timeZoneOffset);
    return formattedTime;
   }
  }
import 'package:izzi_ride_2/core/interfaces/localization_interface.dart';

class EnLocalization implements LocalizationInterface{
  @override
  String get loaderWelcome => "Welcome to iZZi Ride!";

  @override
  String get loaderOther => "Find a ride. Give a ride. Easy ride.";
}
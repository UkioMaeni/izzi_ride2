import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/config/app_config.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc/create_car_bloc.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/city_model.dart';
import 'package:izzi_ride_2/core/models/enum_authorization_type.dart';
import 'package:izzi_ride_2/core/models/enum_ride_booked_status.dart';
import 'package:izzi_ride_2/core/models/enum_ride_status.dart';
import 'package:izzi_ride_2/core/models/enum_ride_type.dart';
import 'package:izzi_ride_2/core/models/enum_role.dart';
import 'package:izzi_ride_2/core/models/geocoding.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/core/models/search_car_brand_and_model.dart';
import 'package:izzi_ride_2/core/models/social.dart';
import 'package:izzi_ride_2/core/models/travaler_model.dart';
import 'package:izzi_ride_2/core/models/user_model.dart';
import 'package:izzi_ride_2/extensions/date_time_extension.dart';

class OrderHttp{
  Dio dio = GetIt.I.get<Dio>(); 
  static OrderHttp Instance = OrderHttp();
  static OrderHttp I = OrderHttp.Instance;
  //ответ на запрос заявки orders
  Future<CustomResponse> answerForAction(bool isAccepted,int appId)async{
    try {
      final result= await dio.post(
        AppConfig.requestUrl+"/order/application/actions",
        data: {
          "command":isAccepted?"accept":"reject",
          "app_id":appId,
        }
      );
      print(result.data);
      return CustomResponse<bool>(data: true);
    } catch (e) {
      print(e);
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }

  Future<int?> getCityId(Location location)async{
    try {
      log("CITY ID search");
      log("IN "+location.city+" // "+location.state);
      final result= await dio.get(
        AppConfig.requestUrl+"/city",
        queryParameters: {
          "state":location.state,
          "city":location.city,
          "latitude":location.latitude,
          "longitude":location.longitude
        }
      );
      print(result.data);
      log("RESULT: "+result.data.toString());
      return result.data["data"]["city_id"];
    } catch (e) {
      print(e);
      return null;
    }
  }
  //бронирование ордера
  Future<CustomResponse> bookOrder(int orderId,int seats)async{
    try {
      final result= await dio.post(
        AppConfig.requestUrl+"/order/book",
        data: {
          "order_id":orderId,
          "number_of_reserved_seats":seats
        }
      );
      print(result.data);
      return CustomResponse<bool>(data: true);
    } catch (e) {
      print(e);
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }

  //отмена брони ордера
  Future<CustomResponse> cancelBooking(int orderId,String comment)async{
    try {
      log("cancelBooking");
      final result= await dio.put(
        AppConfig.requestUrl+"/order/cancel",
        data: {
          "order_id":orderId,
          "comment":comment
        }
      );
      print(result.data);
      return CustomResponse<bool>(data: true);
    } catch (e) {
      print(e);
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }

  Future<CustomResponse> searchOrder(int startPoint,int endPoint,int numberOfSeats,DateTime date,String rideType )async{
    try {
      final result= await dio.get(
        AppConfig.requestUrl+"/orders/find",
        queryParameters: {
          "start_point":startPoint,
          "end_point":endPoint,
          "number_of_seats":numberOfSeats,
          "date":date.toIZZIRIDEFORMAT(),
          "ride_type":rideType,
        },
      );
      print(result.data);
      if(result.data==null){
        return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
      }
      final data=result.data["data"] as List<dynamic>;
      List<RideModel> rides=[];
      for (var data in data) {
        final RideModel ride=RideModel(
          orderId: data["order_id"],
          clientAutoId: -1, 
          comment: "",
          carName: data["driver_car"], 
          price: (data["order_price"]??0)+.0, 
          paymaentMetodId: 0, 
          numberOfSeats: -1, 
          additional:
            Additional()
              ..smoking=data["preference"]["smoking"]
              ..babyChaire=data["preference"]["child_car_seat"]
              ..animals=data["preference"]["animals"]
              ..luggage=data["preference"]["luggage"],
          locations: [], 
          travalers: [], 
          driverRate: 0.0,
          creatorId: -1, 
          driverNickname: data["driver_nickname"], 
          rideStatus: EnumRideStatus.error, 
          rideBookedStatus: EnumRideBookedStatus.error,
          role: Role.error,
          totalSeats: data["seats"]["total"], 
          freeSeats: data["seats"]["free"], 
          date: DateTime.parse(data["departure_time"]??date.toString()), 
          startLocationName: data["start_point"]["city"], 
          endLocationName: data["end_point"]["city"], 
          autoInstant: false, 
          rideType: EnumRideType.client
        );
        rides.add(ride);
      }
      
      return CustomResponse<List<RideModel>>(data: rides);
    } catch (e) {
      log(e.toString());
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }
  Future<CustomResponse> getOrderFullInfo(int orderId )async{
    try {
      final result= await dio.get(
        "${AppConfig.requestUrl}/order/${orderId.toString()}",
      );
      print(result.data);
      if(result.data==null){
        return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
      }
      final data=result.data["data"];

      CarItem carInfo=CarItem(
        carId: -1, 
        brand: data["automobile"]["manufacturer"], 
        model: data["automobile"]["model"], 
        color: data["automobile"]["color"]??"_color_", 
        seats: -1, 
        year: data["automobile"]["year"].toString(),
        number: data["automobile"]["number"]??"_carnumber_"
        
      );
      List<Location> locations=[];
      if(data["locations"]!=null && data["locations"] is List){
        List<dynamic> locs = data["locations"];
        for (var element in locs) {
          Location location = Location(
            city: element["city_name"], 
            state: element["state"], 
            stateShort: "_!_", 
            street: "_!_", 
            homeNumber: "_!_", 
            sortId: element["sort_id"], 
            pickUp: element["pick_up"], 
            location: element["location"], 
            longitude: element["longitude"], 
            latitude: element["latitude"], 
            departureTime: DateTime.now()
          );
          locations.add(location);
        }
      }
      final RideModel ride=RideModel(
          carInfo: carInfo,
          orderId: data["order_id"],
          clientAutoId: data["client_auto_id"], 
          comment: data["comment"],
          carName:"_!_",
          price: (data["order_price"]??0)+.0, 
          paymaentMetodId: 0, 
          numberOfSeats: -1, 
          additional:
            Additional()
              ..smoking=data["preference"]["smoking"]
              ..babyChaire=data["preference"]["child_car_seat"]
              ..animals=data["preference"]["animals"]
              ..luggage=data["preference"]["luggage"],
          locations: locations, 
          travalers: [], 
          driverRate: 0.0, 
          driverNickname: data["nickname"], 
          rideStatus:enumRideStatusFromString(data["created"]??"!"),
          rideBookedStatus:enumRideBookedStatusFromString(data["booked_status"]??"!"),
          role: data["is_driver"]==null?Role.error:(data["is_driver"] as bool)?Role.driver:Role.client,
          totalSeats: data["seats_info"]["total"], 
          freeSeats: data["seats_info"]["free"], 
          date: DateTime.parse(data["departure_time"]??DateTime.now().toString()),
          creatorId: data["driver_id"], 
          startLocationName: "", 
          endLocationName: "", 
          autoInstant: false, 
          rideType: EnumRideType.client
        );
      
      return CustomResponse<RideModel>(data: ride);
    } catch (e) {
      log(e.toString());
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }
}



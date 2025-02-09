import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/config/app_config.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc%20copy/create_car_bloc.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/city_model.dart';
import 'package:izzi_ride_2/core/models/enum_authorization_type.dart';
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
  Future<int?> getCityId(Location location)async{
    try {
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
      return result.data["data"]["city_id"];
    } catch (e) {
      print(e);
      return null;
    }
  }
  Future<int?> searchOrder(int startPoint,int endPoint,int numberOfSeats,DateTime date )async{
    try {
      final result= await dio.get(
        AppConfig.requestUrl+"/orders/find",
        queryParameters: {
          "start_point":startPoint,
          "end_point":endPoint,
          "number_of_seats":numberOfSeats,
          "date":date.toIZZIRIDEFORMAT()

        },
      );
      print(result.data);
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}



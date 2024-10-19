import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:googlemaps_flutter_webservices/places.dart';
import 'package:izzi_ride_2/config/app_config.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/core/models/city_model.dart';
import 'package:izzi_ride_2/core/models/enum_authorization_type.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/response.dart';
class UserHttp{
  Dio dio = GetIt.I.get<Dio>();

  Future<bool> sendOtp(String phoneNumber)async{
    try {
      final result= await dio.get(AppConfig.requestUrl+"/otp?phone=${phoneNumber}");
      print(result);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<CustomResponse> authorization(AuthorizationType type, String code,String phone)async{
    try {
      print("start");
      final result= await dio.post(
        AppConfig.requestUrl+"/authorize",
        data: {
          "type":type.name,
          "code":code,
          "phone":phone
        },
        
      );
      final data = result.data["data"];
      String? accessToken = data["access_token"];
      String? refreshToken = data["refresh_token"];
      bool? isClientNew = data["is_client_new"];
      if(accessToken==null || refreshToken==null || isClientNew==null){
        return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
      }
      final tokenRepo= GetIt.I.get<TokenInterface>();
      tokenRepo.accessToken = accessToken;
      await tokenRepo.setRefreshToken(refreshToken);
      print(isClientNew);
      return CustomResponse<bool>(data: isClientNew);
    } catch (e) {
      print(e);
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }

  Future<CustomResponse> getCityFromGoogle(String text) async{
    try {
     PlacesAutocompleteResponse response = await AppConfig.places.autocomplete(
        text,
        language: "us", 
        types: ["postal_code","sublocality","administrative_area_level_3","locality","street_address"],
        components: [Component(Component.country, "us")],
      );
    List<Prediction> predictions=  response.predictions;

    return CustomResponse<List<Prediction>>(data: predictions);
    } catch (e) {
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
    
  }
  Future<CustomResponse> getMapParamsFromGoogle(String placeId,String description) async{
    try {
      PlacesDetailsResponse details = await AppConfig.places.getDetailsByPlaceId(placeId);
      if(details.errorMessage!=null && details.errorMessage!.isNotEmpty){
        return CustomResponse<CustomErrorRepsonse>(data:CustomErrorRepsonse());
      }
      final mapParams= MapParams(
        placeId: placeId, 
        lon: details.result.geometry!.location.lng, 
        lat: details.result.geometry!.location.lat, 
        description: description
      );
    return CustomResponse<MapParams>(data: mapParams);
    } catch (e) {
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
    
  }
}



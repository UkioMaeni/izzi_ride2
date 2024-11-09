import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:googlemaps_flutter_webservices/places.dart';
import 'package:izzi_ride_2/config/app_config.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/city_model.dart';
import 'package:izzi_ride_2/core/models/enum_authorization_type.dart';
import 'package:izzi_ride_2/core/models/geocoding.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/search_car_brand_and_model.dart';
class UserHttp{
  Dio dio = GetIt.I.get<Dio>(); 
  static UserHttp Instance = UserHttp();
  static UserHttp I = UserHttp.Instance;
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


  Future<CustomResponse> getUserCar()async{
    try {
      print("start");
      final result= await dio.get(
        AppConfig.requestUrl+"/client/auto",
        
      );
      final data = result.data["data"];
      print(data);
      if(data==null){
        return CustomResponse<List<CarItem>>(data: []);
      }
      return CustomResponse<List<CarItem>>(data: []);
    } catch (e) {
      print(e);
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }

  Future<CustomResponse> getCarBrand(String queryString)async{
    try {
      print("start");
      final result= await dio.get(
        AppConfig.requestUrl+"/car/manufacturer",
        queryParameters: {
          "name":queryString,
        }
      );
      final data = result.data["data"];
      print(data);
      if(data==null || data is! List){
        return CustomResponse<List<CarItem>>(data: []);
      }
      List<dynamic> searchedList = data;
      List<SearchCarBrandAndModel> search = searchedList.map(
        (element)=>SearchCarBrandAndModel(
          id:element["id"],
          name: element["name"]
        )
      ).toList();
      return CustomResponse<List<SearchCarBrandAndModel>>(data: search);
    } catch (e) {
      print(e);
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }

  Future<CustomResponse> getCarModel(String queryString,int brandId)async{
    try {
      print("start");
      final result= await dio.get(
        AppConfig.requestUrl+"/car/model",
        queryParameters: {
          "name":queryString,
          "manufacturer_id":brandId
        }
      );
      final data = result.data["data"];
      print(data);
      if(data==null){
        return CustomResponse<List<CarItem>>(data: []);
      }
      return CustomResponse<List<CarItem>>(data: []);
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

  Future<CustomResponse> geocodingFromGoogle(double lat,double lon) async{
    try {
      final geocode = await Dio().get(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat.toString()},${lon.toString()}&key=AIzaSyDQ2a3xgarJk8qlNGzNCLzrH3H_XmGSUaY"
      );
      List<dynamic> addressComponents=geocode.data["results"][0]["address_components"];
      String city="";
      String state="";
      String stateShort="";
      String country="";
      String street="";
      String homeNumber="";
      addressComponents.forEach((element) {
      List<dynamic> elementInfo=element["types"];
      elementInfo.forEach((info) {
        if(info=="locality"|| info=="administrative_area_level_3"){
            city=element["long_name"];
        }
        if(info=="street_number"){
            homeNumber=element["long_name"];
        }
        if(info=="route"){
            street=element["long_name"];
        }
        if(info=="country"){
            country=element["long_name"];
        }
        if(info=="administrative_area_level_1"){
            state=element["long_name"];
            stateShort=element["short_name"];
        }
      });
      if(city.isEmpty){
        city=state;
      }
      });
      Geocoding geocoding = Geocoding();
      geocoding.city=city;
      geocoding.homeNumber=homeNumber;
      geocoding.street=street;
      geocoding.country=country;
      geocoding.state=state;
      geocoding.stateShort=stateShort;
    return CustomResponse<Geocoding>(data: geocoding);
    } catch (e) {
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
    
  }
}



import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:googlemaps_flutter_webservices/places.dart';
import 'package:izzi_ride_2/config/app_config.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc/create_car_bloc.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/city_model.dart';
import 'package:izzi_ride_2/core/models/enum_authorization_type.dart';
import 'package:izzi_ride_2/core/models/enum_checked_status.dart';
import 'package:izzi_ride_2/core/models/enum_ride_booked_status.dart';
import 'package:izzi_ride_2/core/models/enum_ride_status.dart';
import 'package:izzi_ride_2/core/models/enum_ride_type.dart';
import 'package:izzi_ride_2/core/models/enum_role.dart';
import 'package:izzi_ride_2/core/models/geocoding.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/core/models/search_car_brand_and_model.dart';
import 'package:izzi_ride_2/core/models/social.dart';
import 'package:izzi_ride_2/core/models/travaler_model.dart';
import 'package:izzi_ride_2/core/models/user_model.dart';
class UserHttp{

  Dio dio = GetIt.I.get<Dio>(); 
  static UserHttp Instance = UserHttp();
  static UserHttp I = UserHttp.Instance;

   Future<CustomResponse> uploadPhoto(FormData formData)async{
    try {
      final result= await dio.post(
        AppConfig.requestUrl+"/upload",
        data: formData
      );
      print(result);
      if(result.data==null || result.data["data"]==null){
        return CustomResponse<CustomErrorRepsonse>(data:CustomErrorRepsonse());
      }
      String fileUrl=result.data["data"]["file_path"];
      return CustomResponse<String>(data:fileUrl);
    } catch (e) {
      return CustomResponse<CustomErrorRepsonse>(data:CustomErrorRepsonse());
    }
  }
   Future<CustomResponse> sendUserPassportInReview(List<String> photoUrl)async{
    try {
      final result= await dio.put(
        AppConfig.requestUrl+"/client/identification",
        data: {
          "photo":photoUrl
        }
      );
      print(result);
      return CustomResponse<bool>(data:true);
    } catch (e) {
      return CustomResponse<CustomErrorRepsonse>(data:CustomErrorRepsonse());
    }
  }
  Future<CustomResponse> setUserPhoto(String photoUrl)async{
    try {
      final result= await dio.post(
        AppConfig.requestUrl+"/client/info",
        data: {
          "photo":photoUrl
        }
      );
      print(result);
      return CustomResponse<bool>(data:true);
    } catch (e) {
      return CustomResponse<CustomErrorRepsonse>(data:CustomErrorRepsonse());
    }
  }
  Future<bool> sendOtp(String phoneNumber)async{
    try {
      final result= await dio.get(AppConfig.requestUrl+"/otp?phone=${phoneNumber}");
      print(result);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<CustomResponse> getMeInfo()async{
    try {
      print("start");
      final result= await dio.get(
        AppConfig.requestUrl+"/client/info",
      );
      final data = result.data["data"];
      if(data==null){
        return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
      }

      print(data);
      final userData= UserModel(
        clienId: data["client_id"]??0, 
        dateOfBirth:parseDate(data["date_of_birth"]),
        gender: data["gender"]??"male", 
        name: data["name"]??"NoName", 
        nickname: data["nickname"]??"NoName", 
        photo: data["photo"], 
        surname: data["surname"]??"NoSurname",
        rate: (data["rate"]??0)+0.0,
        emailConfirmed: data["email_confirmed"],
        passportConfirmed: CheckedStatusTools.fromString(data["passport_status"]) ,
        firstRegisterDate: parseDate(data["first_register_date"]),
        phoneConfirmed: data["phone_confirmed"],
        socialPlatforms: ((data["social_platforms"]??[]) as List<dynamic>).map((elem)=>Social(id: elem["id"],platformId: elem["platform_id"],link: elem["profile_link"])).toList()
      );
      
      return CustomResponse<UserModel>(data: userData);
    } catch (e) {
      print(e);
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }

  DateTime? parseDate(String? str){
    try {
      if(str==null){
        return null;
      }
      return DateTime.parse(str);
    } catch (e) {
      return null;
    }
  }

  Future<CustomResponse> setInitUserData(String name,String surname)async{
    try {
      print("initialData");
      final result= await dio.post(
        AppConfig.requestUrl+"/client/info",
        data: {
          "name":name,
          "surname":surname
        }
      );
      print(result.data);
      return CustomResponse<bool>(data: true);
      
    } catch (e) {
      print(e);
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
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
      if(data==null || data is! List){
        return CustomResponse<List<CarItem>>(data: []);
      }
      List<dynamic> listResponse = data;
      List<CarItem> cars = listResponse.map(
        (element) => CarItem(
          carId: element["car_id"],
          brand: element["manufacturer"], 
          model: element["model"], 
          color: element["color"]??"no",
          seats:element["number_of_seats"],
          year: element["year"],
          number: element["number"]??"_carnumber_"
        ) 
      ).toList();
      return CustomResponse<List<CarItem>>(data: cars);
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

  Future<CustomResponse> createUserCar(CreateCarState state)async{
    try {
      print("start");
      final result= await dio.post(
        AppConfig.requestUrl+"/client/auto",
        data: {
          "model_id":state.model.id,
          "manufacturer_id":state.brand.id,
          "number_of_seats":state.seats,
          "color":state.colorCar.stringColor,
          "auto_number":state.carNumber,
          "year":state.carYear,
        }
      );
      final data = result.data["data"];
      print(data);
      
      return CustomResponse<bool>(data: true);
    } catch (e) {
      print(e);
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }

  Future<CustomResponse> createUserRide(RideModel ride)async{
    try {
      print("start");
      final result= await dio.post(
        AppConfig.requestUrl+"/order",
        data: ride.toJson()
      );
      final data = result.data["data"];
      print(data);
      print("done");
      return CustomResponse<bool>(data: true);
    } catch (e) {
      print(e);
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }
  Future<CustomResponse> getMyTrips()async{
    try {
      final result= await dio.get(
        "${AppConfig.requestUrl}/client/orders/booked",
      );
      final data = result.data["data"];
      print(data);
      if(data==null || data is! List){
        return CustomResponse<List<CarItem>>(data: []);
      }
      
      List<dynamic> responsedList = data;
      List<RideModel> rides = responsedList.map(
        (element){
          log(element.toString());
          return RideModel(
          creatorId: -1,
          orderId: element["order_id"],
          clientAutoId: element["client_auto_id"]??0, 
          driverRate: (element["driver_rate"]??0)+.0,
          driverNickname: element["driver_nickname"],
          date: DateTime.parse(element["departure_time"]),
          rideStatus: enumRideStatusFromString(element["status"]??"!") ,
          rideBookedStatus: enumRideBookedStatusFromString(element["booked_status"]??"!"),
          startLocationName: element["start_point"]["city"],
          endLocationName: element["end_point"]["city"],
          totalSeats: element["seats"]["total"],
          freeSeats: element["seats"]["free"],
          price: (element["order_price"]??0)+.0,
           
          additional: 
            Additional()
              ..smoking=element["preference"]["smoking"]
              ..babyChaire=element["preference"]["child_car_seat"]
              ..animals=element["preference"]["animals"]
              ..luggage=element["preference"]["luggage"], 
          locations: [],
          travalers: ((element["travelers"]??[]) as List<dynamic> ).map((el)=>TravalerModel(id: el["id"],avatarUrl: el["avatar_url"],hasOrderRate: el["has_order_rate"],name: el["name"],surname: el["surname"],applicationId: el["app_id"],nickname: el["nickname"],statusName:el["status_name"], rate: (el["rate"]??0)+.0)).toList(),
          comment: "",
          numberOfSeats: 0,
          autoInstant: false,
          paymaentMetodId: 1,
          rideType: EnumRideType.client,
          role: Role.error,
          carName: ""
        );
        }
      ).toList();
      
      
      
      return CustomResponse<List<RideModel>>(data: rides);
    } catch (e) {
      print(e);
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }
  Future<CustomResponse> getUserRides({int? id})async{
    try {
      print("start");
      final result= await dio.get(
        "${AppConfig.requestUrl}/driver/orders"+(id!=null?"?id=${id}":""),
      );
      final data = result.data["data"];
      if(data==null || data is! List){
        return CustomResponse<List<CarItem>>(data: []);
      }
      
      List<dynamic> responsedList = data;
      List<RideModel> rides = responsedList.map(
        (element){
          log(element.toString());
          return RideModel(
          creatorId: -1,
          orderId: element["order_id"],
          clientAutoId: element["client_auto_id"], 
          driverRate: (element["driver_rate"]??0)+.0,
          driverNickname: element["nickname"],
          date: DateTime.parse(element["departure_time"]),
          rideStatus: enumRideStatusFromString(element["status"]??"!") ,
          rideBookedStatus: enumRideBookedStatusFromString(element["status"]??"!") ,
          startLocationName: element["start_country_name"],
          endLocationName: element["end_country_name"],
          totalSeats: element["seats_info"]["total"],
          freeSeats: element["seats_info"]["free"],
          price: (element["price"]??0)+.0,
           
          additional: 
            Additional()
              ..smoking=element["preference"]["smoking"]
              ..babyChaire=element["preference"]["child_car_seat"]
              ..animals=element["preference"]["animals"]
              ..luggage=element["preference"]["luggage"], 
          locations: [],
          travalers: ((element["travelers"]??[]) as List<dynamic> ).map((el)=>TravalerModel(id: el["id"],avatarUrl: el["avatar_url"],hasOrderRate: el["has_order_rate"],name: el["name"],surname: el["surname"],applicationId: el["app_id"],nickname: el["nickname"],statusName:el["status_name"], rate: (el["rate"]??0)+.0)).toList(),
          comment: "",
          numberOfSeats: 0,
          autoInstant: false,
          paymaentMetodId: 1,
          rideType: EnumRideType.driver,
          role: Role.error,
          carName: ""
        );
        }
      ).toList();
      
      
      
      return CustomResponse<List<RideModel>>(data: rides);
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
      print(response);
    List<Prediction> predictions=  response.predictions;

    return CustomResponse<List<Prediction>>(data: predictions);
    } catch (e) {
      print(e);
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



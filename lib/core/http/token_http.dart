import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/config/app_config.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/core/models/enum_authorization_type.dart';
import 'package:izzi_ride_2/core/models/response.dart';

class TokenHttp{
  Dio dio = Dio();

  Future<CustomResponse> refreshToken(String token)async{
    try {
      print("token for refresh "+token);
      final result= await dio.post(
        AppConfig.requestUrl+"/refresh-token",
        data: {
          "token":token
        },
        options: Options(
          extra: {
            "type":"refresh"
          }
        )
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
      print(data);
      return CustomResponse<bool>(data: isClientNew);
    } catch (e) {
      print(e);
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }
  
  
}



import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/config/app_config.dart';
import 'package:izzi_ride_2/core/models/chat_model.dart';
import 'package:izzi_ride_2/core/models/member_model.dart';
import 'package:izzi_ride_2/core/models/message_model.dart';
import 'package:izzi_ride_2/core/models/payment_intent_model.dart';
import 'package:izzi_ride_2/core/models/response.dart';

class PaymentHttp{
  Dio dio = GetIt.I.get<Dio>(); 
  static PaymentHttp Instance = PaymentHttp();
  static PaymentHttp I = PaymentHttp.Instance;

  Future<CustomResponse> init()async{
    try {
      final result= await dio.post(
        AppConfig.requestUrl+"/payment/intent",
        data: {

        },
      );
      log(result.data.toString());
      if(result.data["data"]==null){
        return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
      }
      final data = result.data["data"];
      
      PaymentIntentModel paymentIntentModel = PaymentIntentModel(
        clientSecret: data["client_secret"],
        ephermKey: data["ephermKey"],
        customerId: data["customerID"],
      );
      return CustomResponse<PaymentIntentModel>(data: paymentIntentModel);
    } catch (e) {
      log(e.toString());
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }
}






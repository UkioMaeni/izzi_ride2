import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:izzi_ride_2/core/http/chat_http.dart';
import 'package:izzi_ride_2/core/http/order_http.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/chat_model.dart';
import 'package:izzi_ride_2/core/models/message_model.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/travaler_model.dart';
import 'package:izzi_ride_2/core/socket/app_socket.dart';
import 'package:provider/provider.dart';

class ActionsRideProvider extends ChangeNotifier{
  List<TravalerModel> newTravalers=[];
  int currentOrderId=-1;
  setNewTravalers(List<TravalerModel> travalers,int orderId){
    currentOrderId=orderId;
    newTravalers=travalers;
    notifyListeners();
  }
  Future<bool> approve(int appId)async{
    final result =  await OrderHttp.I.answerForAction(true,appId);
    if(result is CustomResponse<bool>){
      return true;
    }else{
      return false;
    }
  }
  Future<bool> reject(int appId)async{
    final result = await OrderHttp.I.answerForAction(true,appId);
    if(result is CustomResponse<bool>){
      return true;
    }else{
      return false;
    }
  }
}

ActionsRideProvider actionsRideProvider= ActionsRideProvider();
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/config/app_config.dart';
import 'package:izzi_ride_2/core/models/response.dart';

class ChatHttp{
  Dio dio = GetIt.I.get<Dio>(); 
  static ChatHttp Instance = ChatHttp();
  static ChatHttp I = ChatHttp.Instance;

  Future<CustomResponse> getChatId(int orderId,int clientId)async{
    try {
      final result= await dio.post(
        AppConfig.requestUrl+"/chat",
        data: {
            "order_id":orderId,
            "client_id":clientId
        },
      );
      if(result.data["data"]["chat_id"]==null){
        return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
      }
      int chatId=result.data["data"]["chat_id"];
      return CustomResponse<int>(data: chatId);
    } catch (e) {
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }
  
}



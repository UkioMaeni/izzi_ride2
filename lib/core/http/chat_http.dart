import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/config/app_config.dart';
import 'package:izzi_ride_2/core/models/chat_model.dart';
import 'package:izzi_ride_2/core/models/member_model.dart';
import 'package:izzi_ride_2/core/models/message_model.dart';
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
  Future<CustomResponse> getChats()async{
    try {
      final result= await dio.get(
        AppConfig.requestUrl+"/client/chats",
      );
      print(result.data);
      if(result.data==null||result.data["data"]==null){
        return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
      }
      List<dynamic> data=result.data["data"];
      List<Chat> chats=[];
      for (var element in data) {

        List<Message> messages=[];
        if(element["message"]!=null){
            log(element["message"]["type"].toString());
          if(element["message"]["type"]=="0"){
            log("TYPE 0");
            Message message = TextMessage(
              chatId: element["chat_id"],
              id: element["message"]["id"],
              clientId: element["message"]["client_id"],
              frontContentId: element["message"]["front_content_id"],
              messageTime: DateTime.parse(element["message"]["message_time"]??DateTime.now()),
              content: element["message"]["content"],
              status: element["message"]["status"],
            );
            messages.add(message);
          }
        }

        List<Member> members=[];
        if(element["members"]!=null){
          List<dynamic> _members=element["members"];
          for (var _member in _members) {
            Member member = Member(
              clientId: _member["client_id"],
              clientName: _member["client_name"],
              photo: _member["photo"],
              status: _member["status"],
            );
            members.add(member);
          } 
        }
        Chat chat = Chat(
          messages: messages,
          chatId: element["chat_id"], 
          chat_status: element["chat_status"], 
          endLocation: element["end"], 
          startLocation: element["start"], 
          members: members, 
          orderId: element["order_id"], 
          unreadMessages: element["unread_messages"]
        );
        chats.add(chat);
      }
      return CustomResponse<List<Chat>>(data: chats);
    } catch (e) {
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }
  Future<CustomResponse> getMessagesInChatById(int chatId)async{
    try {
      
      final result= await dio.get(
        AppConfig.requestUrl+"/chat/history/$chatId",
      );
      log("get messages");
      print(result.data);
      if(result.data==null||result.data["data"]==null){
        return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
      }
      List<dynamic> chatsData=result.data["data"]["messages"]??[];
      log(chatsData.toString());
      List<Message> messages=[];
      for(var element in chatsData){
        if(element["message_type"]=="0"){
          Message mess = TextMessage(
            id: element["message_id"], 
            clientId: element["client_id"], 
            status: element["message_id"]??0, 
            frontContentId: element["front_content_id"]??"", 
            messageTime:DateTime.parse(element["created_at"]??DateTime.now()), 
            chatId: chatId,
            content: element["message"]
          );
          messages.insert(0, mess);
        }
        
      }
      log("messages in chatId ${chatId}");
      log(messages.length.toString());
      return CustomResponse<List<Message>>(data: messages);
    } catch (e) {
      return CustomResponse<CustomErrorRepsonse>(data: CustomErrorRepsonse());
    }
  }
  
}



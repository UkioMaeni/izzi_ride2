import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:izzi_ride_2/core/http/chat_http.dart';
import 'package:izzi_ride_2/core/models/chat_model.dart';
import 'package:izzi_ride_2/core/models/message_model.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/socket/app_socket.dart';
import 'package:provider/provider.dart';

class ChatSProvider extends ChangeNotifier{
  List<Chat> chats;
  bool firstLoading;
  int currentChatId;
  ChatSProvider({
    required this.chats,
    required this.firstLoading,
    required this.currentChatId
  });

  static  ChatSProvider empty(){
    return ChatSProvider(
      chats: [],
      firstLoading: false,
      currentChatId: -1
    );
  }
  
  Future<void> getChats()async{
    final result=await ChatHttp.I.getChats();
      if(result is CustomResponse<List<Chat>>){
        chats=result.data;
      }
      firstLoading=true;
      for (var element in chats) {
        final result=await ChatHttp.I.getMessagesInChatById(element.chatId);
        if(result is CustomResponse<List<Message>>){
          log(result.data.length.toString());
          element.messages=result.data;
        }
      }
      notifyListeners();
  }
  Future<void> getChat()async{
    final result=await ChatHttp.I.getChats();
      if(result is CustomResponse<List<Chat>>){
        chats=result.data;
      }
      firstLoading=true;
      for (var element in chats) {
        final result=await ChatHttp.I.getMessagesInChatById(element.chatId);
        if(result is CustomResponse<List<Message>>){
          element.messages=result.data;
        }
      }
      notifyListeners();
  }
  void setCurrentChat(int chatId){
    currentChatId=chatId;
    notifyListeners();
  }
  sendMessage(Message message){
      
      final chatId = message.chatId;

      //поиск чата
      bool findChat=false;
      Chat chat=Chat.nullable(); 
      for(var element in chats){
        if(element.chatId==chatId){
          findChat=true;
          chat=element;
          break;
        }
      }
      if(findChat){
        chat.messages.insert(0,message);
        appSocket.sendMessage(message);
      }else{
        //TODO 
      }
      notifyListeners();
  }
  void editStatus(int chatId,int status,String frontContentId,DateTime time){
      Chat chat=Chat.nullable();
      bool find=false;
      for(var element in chats){
        if(element.chatId==chatId){
          chat=element;
          find=true;
          break;
        }
      }
      if(find){
        for(var mess in chat.messages){
          if(mess.frontContentId==frontContentId){
            mess.status=status;
            mess.messageTime=time;
          }
        }
      }
      notifyListeners();

  }
  ///переменная служит для рекурентного выхода в случае ошибки на [receiveMessage]
  int getChatReciveCount=0;
  receiveMessage(Message message)async{
    getChatReciveCount=1;
    final chatId = message.chatId;
    bool findChat=false;
      Chat chat=Chat.nullable(); 
      for(var element in chats){
        if(element.chatId==chatId){
          findChat=true;
          chat=element;
          break;
        }
      }
      if(findChat){
        chat.messages.insert(0,message);
        if(currentChatId!=1){
          appSocket.fullReadMessage(currentChatId);
        }
        
        notifyListeners();
      }else{
        if(getChatReciveCount<3){
          await getChat();
          receiveMessage(message);
        }else{
          getChatReciveCount=0;
        }
        
      }
  }
  fullRead(int chatId){
    bool findChat=false;
      Chat chat=Chat.nullable(); 
      for(var element in chats){
        if(element.chatId==chatId){
          findChat=true;
          chat=element;
          break;
        }
      }
      if(findChat){
        for(var mess in chat.messages){
          mess.status=1;
          notifyListeners();
        }
      }else{
        
      }
  }

  RESET_DATA(){
    chatProvider=ChatSProvider.empty();
  }
}

ChatSProvider chatProvider= ChatSProvider.empty();
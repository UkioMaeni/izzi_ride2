import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/http/chat_http.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/additional.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/models/chat_model.dart';
import 'package:izzi_ride_2/core/models/location.dart';
import 'package:izzi_ride_2/core/models/map_params.dart';
import 'package:izzi_ride_2/core/models/message_model.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/core/socket/app_socket.dart';
import 'package:uuid/uuid.dart';

part 'chats_state.dart';
part 'chats_event.dart';

class ChatsBloc extends Bloc<ChatsEvent,CtatsFullState>{
  
  ChatsBloc():super(CtatsFullState.empty()){
    on<ChatsGetChats>((event, emit)async{
      final result=await ChatHttp.I.getChats();
      if(result is CustomResponse<List<Chat>>){
        state.chats=result.data;
      }
      state.firstLoading=true;
      emit(state);
      for (var element in state.chats) {
        ChatHttp.I.getMessagesInChatById(element.chatId);
      }
      }
    );
    on<ChatsSetCurrentChat>((event, emit)async{
      state.currentChatId=event.chatId;
      emit(state);
    });
    on<ChatsSendMessage>((event, emit)async{
      Message message = event.message;
      
      final chatId = message.chatId;

      //поиск чата
      bool findChat=false;
      Chat chat=Chat.nullable(); 
      for(var element in state.chats){
        if(element.chatId==chatId){
          findChat=true;
          chat=element;
          break;
        }
      }
      if(findChat){
        chat.messages.add(message);
        appSocket.sendMessage(message);
        
      }else{
        //TODO 
      }
      log("emit");
      emit(state);
    });
    
  }
  
}
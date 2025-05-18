import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/core/models/message_model.dart';
import 'package:izzi_ride_2/core/providers/chat_provider.dart';
import 'package:uuid/uuid.dart';



class SocketMessage{
  String type;
  SocketMessage({
    required this.type
  });
}



class SocketProvider {
  WebSocket? channel;
  Uuid uuid=const  Uuid();
  static bool isConnect=false;

  final StreamController<int> _ridesTrigger = StreamController<int>.broadcast();
  StreamController<int>  get  ridesTrigger =>_ridesTrigger;

  void connect()async{
    try {
    
    WebSocket conn =await WebSocket.connect("ws://194.135.105.117:8090/api/v1/chat/join");
    conn.pingInterval=Duration(seconds: 1);
    channel=conn;
    SocketProvider.isConnect=true;
    //chatsRepository.getChats();
    channel!.listen((event) async{ 
     
      print("socket!");
      print(event+"///");
      if(event=="token not valid"){
        return;
      }
        final parseMessage=json.decode(event);
        
        SocketMessage message=SocketMessage(type: parseMessage["type"]);
        if(message.type=="connection"){
          String? accessToken = GetIt.I.get<TokenInterface>().accessToken;
            final token=accessToken;
            final message=json.encode({
              "token":token,
              "type":"auth"
            });
            print(message);
              channel?.add(message);
        }
        if(message.type=="auth"){
          print("SOCKET CONNECT");
          //checkUnread();
         
            // final message = json.encode({
            //   "client_id":122,
            //   "front_hash_id":1,
            //   "type":"message",
            //   "chat_id":4,
            //   "content":"211"
            // });
            // channel.sink.add(message);
            
              
        }
        if(message.type=="cancel-client"){
          Map<String,dynamic> booking=json.decode(event);
          int orderId=booking["order_id"]??-1;
          
          print("DELETEEE");
        }
        if(message.type=="booking"){
          Map<String,dynamic> booking=json.decode(event);
          int orderId=booking["orderId"];
          // int newStatus
          // userRepository.editStatusOrder(orderId, newStatus)
          print("DELETEEE");
        }
        // if(message.type=="booking_driver"){
        //   Map<String,dynamic> bookingDriver=json.decode(event);
        //   int orderId=bookingDriver["order_id"];
        //   String statusName=bookingDriver["status_name"];
        //   //userRepository.editUserOrdersSeatsInOrder(orderId,statusName);
        // }
        if(message.type=="cancel-client"){
          Map<String,dynamic> cancelClient=json.decode(event);
          int senderId=cancelClient["sender_id"];
          String time=cancelClient["sent_time"];
          int orderId=cancelClient["order_id"];
          //userRepository.cancelBookedOrderByUser(orderId);
          int chatId=cancelClient["chat_id"]??-1;
          // if(chatId==-1 || chatsRepository.chats[chatId.toString()]==null){
          //   return;
          // }
          // Message newmsg=Message(content: "Driver removed you from order", status: 0, frontContentId: "",chatId: chatId, time:time,id: -1,senderClientId: -1,type: "1" );
          // chatsRepository.addMessage(newmsg);
          // chatsRepository.updateStatusChat(chatId);
          // chatsRepository.chats.forEach((key, value) { 
          //   if(value.orderId==)
          // });

         
        }
        if(message.type=="cancel-order"){
          Map<String,dynamic> cancelClient=json.decode(event);
          int senderId=cancelClient["sender_id"];
          String time=cancelClient["sent_time"];
          int orderId=cancelClient["order_id"];
          // userRepository.cancelBookedOrderByUser(orderId);
          // int chatId=cancelClient["chat_id"]??-1;
          // if(chatId==-1 || chatsRepository.chats[chatId.toString()]==null){
          //   return;
          // }
          // Message newmsg=Message(content: "Driver cancelled order", status: 0, frontContentId: "",chatId: chatId, time:time,id: -1,senderClientId: -1,type: "1" );
          // chatsRepository.addMessage(newmsg);
          // chatsRepository.updateStatusChat(chatId);
        }
        if(message.type=="message-itself"){
          Map<String,dynamic> statusMsg=json.decode(event);
          int status=statusMsg["status"];
          int messageId=statusMsg["content_id"];
            int chatId=statusMsg["chat_id"];
            DateTime time=DateTime.parse(statusMsg["sent_time"]??DateTime.now().toString());
            print(time);
            String frontContentId=statusMsg["front_content_id"];
            chatProvider.editStatus(chatId, status, frontContentId, time);
          // editStatus(chatId,uuId,status);
          
        }
        if(message.type=="booking_driver"){
          log("booking_driver EVENT");
          Map<String,dynamic> statusMsg=json.decode(event);
          String statusName = statusMsg["status_name"];
          int orderId=statusMsg["order_id"];
          log("orderid EVENT"+orderId.toString());
          ridesTrigger.add(orderId);
          //chatProvider.editStatus(chatId, status, frontContentId, time);
          // editStatus(chatId,uuId,status);
          
        }
        if(message.type=="message"){
          Map<String,dynamic> mess=json.decode(event);
          print(mess);
           
            Message newmsg=TextMessage(
              id: mess["content_id"], 
              clientId: mess["sender_id"], 
              status: mess["status"], 
              frontContentId: mess["front_content_id"], 
              messageTime: DateTime.parse(mess["sent_time"]), 
              chatId: mess["chat_id"], 
              content: mess["content"]
            );
          //Message newmsg=Message(content: mess["content"], status: mess["status"], frontContentId: mess["front_content_id"],chatId: mess["chat_id"], time:mess["sent_time"],id: mess["content_id"],senderClientId: mess["sender_id"],type: mess["type"] );
            chatProvider.receiveMessage(newmsg);
        }
        
        if(message.type=="full-read"){
           Map<String,dynamic> mess=json.decode(event);
           int chatId=mess["chat_id"];
            chatProvider.fullRead(chatId);

        }

   },
   onError: (error){
        print("eDISCONNECT");
          if(error is SocketException){
            print(error);
          }
      },
      onDone: () {
        print("DISCONNECT");
         if(channel!=null){
            channel!.close();

          }
     SocketProvider.isConnect=false;
      print("Повторное подключение");
      Future.delayed(Duration(seconds: 1)).then((value){
        print("reconnect onDONE");
        if(!SocketProvider.isConnect){
            connect();
        }
        
      });

      },
   );
    
    } catch (e) {
      print(e);
     if(channel!=null){
       channel!.close();

     }
     SocketProvider.isConnect=false;
      print("Повторное подключение");
      Future.delayed(Duration(seconds: 1)).then((value){
        print("reconnect CATCH");
         if(!SocketProvider.isConnect){
            connect();
        }
      });
    }
      
   }





  Future<void> sendMessage(Message mess)async{
    Map<String,dynamic> message={
      "front_content_id": mess.frontContentId,
      "type":"message",
      "content":(mess as TextMessage).content,
      "chat_id":mess.chatId
    };
    if(SocketProvider.isConnect==false){
      return;
    }
     channel?.add(json.encode(message));
     
  }

  fullReadMessage(int chatId){
    print("send read");
    Map<String,dynamic> read={
      "chat_id":chatId,
      "type":"message-read"
     };
     print(json.encode(read));
     channel?.add(json.encode(read));
  }


}

SocketProvider appSocket=SocketProvider();
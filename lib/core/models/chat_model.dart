import 'package:izzi_ride_2/core/models/member_model.dart';
import 'package:izzi_ride_2/core/models/message_model.dart';

class Chat{
  int chatId;
  int unreadMessages;
  int orderId;
  bool chat_status;
  String startLocation;
  String endLocation;
  List<Member> members;
  List<Message> messages;
  Chat({
    required this.messages,
    required this.chatId,
    required this.chat_status,
    required this.endLocation,
    required this.startLocation,
    required this.members,
    required this.orderId,
    required this.unreadMessages
  });

  static Chat nullable(){
    return Chat(
      messages: [], 
      chatId: -1,
      chat_status: false,
      endLocation: "", 
      startLocation: "", 
      members: [], 
      orderId: -1, 
      unreadMessages: -1
    );
  }
}
part of 'chats_bloc.dart';

abstract class ChatsEvent{
  const ChatsEvent();
}




class ChatsGetChats extends ChatsEvent{
  const ChatsGetChats();
}
class ChatsSetCurrentChat extends ChatsEvent{
  final int chatId;
  const ChatsSetCurrentChat({required this.chatId});
}

class ChatsSendMessage extends ChatsEvent{
  final Message message;
  const ChatsSendMessage({required this.message});
}
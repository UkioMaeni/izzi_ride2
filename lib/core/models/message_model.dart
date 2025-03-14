class Message{
  int chatId;
  int id;
  int clientId;
  int status;
  String frontContentId;
  DateTime messageTime;
  Message({
    required this.id,
    required this.clientId,
    required this.status,
    required this.frontContentId,
    required this.messageTime,
    required this.chatId
  });
}

class TextMessage extends Message{
  String content;
  TextMessage({
    required super.id,
    required super.clientId,
    required super.status,
    required super.frontContentId,
    required super.messageTime,
    required super.chatId,
    required this.content,
    
  });
}
class GeoMessage extends Message{
  GeoMessage({
    required super.id,
    required super.clientId,
    required super.status,
    required super.frontContentId,
    required super.messageTime,
    required super.chatId,
  });
}
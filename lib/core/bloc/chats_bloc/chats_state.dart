part of 'chats_bloc.dart';




class CtatsFullState {
  
  List<Chat> chats;
  bool firstLoading;
  int currentChatId;
  CtatsFullState({
    required this.chats,
    required this.firstLoading,
    required this.currentChatId
  });

  static  CtatsFullState empty(){
    return CtatsFullState(
      chats: [],
      firstLoading: false,
      currentChatId: -1
    );
  }
  
  // copyWith({
  //     List<RideModel>? rides,
  //     bool? requsted,
  //   }){
  //   return RidesFullState(
  //     rides: rides??this.rides,
  //     requsted: requsted??this.requsted
  //   );
  // }

}
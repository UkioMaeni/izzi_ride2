part of 'user_me_bloc.dart';




class UserMeState {
  
  UserModel? me;
  bool requsted;
  bool hasUnhundledError;
  UserMeState({
    required this.me,
    required this.requsted,
    required this.hasUnhundledError,
  });

  static  UserMeState empty(){
    return UserMeState(
      me: null,
      requsted: false,
      hasUnhundledError:false 
    );
  }
  copyWith({
      UserModel? me,
      bool? requsted,
      bool? hasUnhundledError,
    }){
    return UserMeState(
      me: me??this.me,
      requsted: requsted??this.requsted,
      hasUnhundledError: hasUnhundledError??this.hasUnhundledError,
    );
  }

}
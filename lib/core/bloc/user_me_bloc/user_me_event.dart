part of 'user_me_bloc.dart';

abstract class UserMeEvent{
  const UserMeEvent();
}

enum Scene{
  initial,
  fromInput,
  fromMap,
  toInput,
  toMap,
  selectDate,
  selectTime,
  selectCar,
  additional
}



class UserMeGetMeInfo extends UserMeEvent{
  const UserMeGetMeInfo();
}

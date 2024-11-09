part of 'rides_bloc.dart';

abstract class RidesEvent{
  const RidesEvent();
}




class RidesGetUserRides extends RidesEvent{
  const RidesGetUserRides();
}

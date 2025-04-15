part of 'rides_bloc.dart';

abstract class RidesEvent{
  const RidesEvent();
}




class RidesGetUserRides extends RidesEvent{
  const RidesGetUserRides();
}

class RidesUpdateRide extends RidesEvent{
  final int orderId;
  const RidesUpdateRide({required this.orderId});
}

class RidesEditStatusTravalerInRide extends RidesEvent{
  final int orderId;
  final int travalerId;
  final String status;
  const RidesEditStatusTravalerInRide({required this.orderId,required this.travalerId,required this.status});
}

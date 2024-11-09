part of 'create_ride_bloc.dart';

abstract class CreateRideEvent{
  const CreateRideEvent();
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



class CreateRideEditScene extends CreateRideEvent{
  final Scene newScene;
  const CreateRideEditScene({required this.newScene});
}

class CreateRideSetMapParams extends CreateRideEvent{
  final MapParams mapParams;
  final SceneType type;
  const CreateRideSetMapParams({required this.mapParams,required this.type});
}
class CreateRideSetFromLocation extends CreateRideEvent{
  final Location location;
  const CreateRideSetFromLocation({required this.location});
}
class CreateRideSetToLocation extends CreateRideEvent{
  final Location location;
  const CreateRideSetToLocation({required this.location});
}
class CreateRideSetCar extends CreateRideEvent{
  final CarItem carItem;
  const CreateRideSetCar({required this.carItem});
}
class CreateRideEditAdditional extends CreateRideEvent{
  final Additional additional;
  const CreateRideEditAdditional({required this.additional});
}
class CreateRideEditComment extends CreateRideEvent{
  final String comment;
  const CreateRideEditComment({required this.comment});
}
class CreateRideEditPrice extends CreateRideEvent{
  final int price;
  const CreateRideEditPrice({required this.price});
}
class CreateRideEditDate extends CreateRideEvent{
  final DateTime date;
  const CreateRideEditDate({required this.date});
}
class CreateRideEditTime extends CreateRideEvent{
  final TimeOfDay time;
  const CreateRideEditTime({required this.time});
}
class CreateRideSetAutoInstant extends CreateRideEvent{
  final bool autoInstant;
  const CreateRideSetAutoInstant({required this.autoInstant});
}
// class LocalizationSetLocaleEvent extends RegistrationEvent{
//   final LocalizationInterface localeState;
//   final Locale locale;
//   LocalizationSetLocaleEvent({required this.locale,required this.localeState});
// }
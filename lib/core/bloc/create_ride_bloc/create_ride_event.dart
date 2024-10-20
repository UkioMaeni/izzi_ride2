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

class CreateRideNextScene extends CreateRideEvent{
  const CreateRideNextScene();
}
class CreateRideBackScene extends CreateRideEvent{
  const CreateRideBackScene();
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
// class LocalizationSetLocaleEvent extends RegistrationEvent{
//   final LocalizationInterface localeState;
//   final Locale locale;
//   LocalizationSetLocaleEvent({required this.locale,required this.localeState});
// }
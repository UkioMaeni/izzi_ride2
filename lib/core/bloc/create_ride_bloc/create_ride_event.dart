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
  const CreateRideSetMapParams({required this.mapParams});
}
// class LocalizationSetLocaleEvent extends RegistrationEvent{
//   final LocalizationInterface localeState;
//   final Locale locale;
//   LocalizationSetLocaleEvent({required this.locale,required this.localeState});
// }
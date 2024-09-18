part of 'registration_bloc.dart';

abstract class RegistrationEvent{
  const RegistrationEvent();
}

class RegistrationUpdateNumber extends RegistrationEvent{
  final String phoneNumber;
  const RegistrationUpdateNumber({required this.phoneNumber});
}

class RegistrationUpdateCode extends RegistrationEvent{
  final String code;
  const RegistrationUpdateCode({required this.code});
}



// class LocalizationSetLocaleEvent extends RegistrationEvent{
//   final LocalizationInterface localeState;
//   final Locale locale;
//   LocalizationSetLocaleEvent({required this.locale,required this.localeState});
// }
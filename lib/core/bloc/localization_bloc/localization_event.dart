part of 'localization_bloc.dart';

abstract class LocalizationEvent{
  const LocalizationEvent();
}

class LocalizationSetLocaleEvent extends LocalizationEvent{
  final LocalizationInterface localeState;
  final Locale locale;
  LocalizationSetLocaleEvent({required this.locale,required this.localeState});
}
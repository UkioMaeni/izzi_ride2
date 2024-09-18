part of 'localization_bloc.dart';



abstract class LocalizationState{
  const LocalizationState();
}

class LocalizationLocaleState extends LocalizationState{
  final LocalizationInterface localeState;
  final Locale locale;
  const LocalizationLocaleState({required this.locale,required this.localeState});
}
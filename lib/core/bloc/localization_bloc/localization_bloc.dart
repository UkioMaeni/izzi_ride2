import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/interfaces/localization_interface.dart';
import 'package:izzi_ride_2/core/models/localization.dart';

part 'localization_state.dart';
part 'localization_event.dart';

class LocalizationBloc extends Bloc<LocalizationEvent,LocalizationState>{
  LocalizationBloc():super(LocalizationLocaleState(localeState: EnLocalization(),locale: Locale("en","US"))){
    on<LocalizationSetLocaleEvent>((event, emit)async{
      emit( LocalizationLocaleState(localeState:event.localeState,locale: event.locale));
    });

  }
  
}
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registration_state.dart';
part 'registration_event.dart';

class RegistrationBloc extends Bloc<RegistrationEvent,RegistrationFullState>{
  RegistrationBloc():super(RegistrationFullState.empty()){
    on<RegistrationUpdateNumber>((event, emit)async{
      emit(state.copyWith(phoneNumber: event.phoneNumber));
    });
    on<RegistrationUpdateCode>((event, emit)async{
      emit(state.copyWith(code: event.code));
    });
    on<Registration_RESET_DATA>((event, emit)async{
      emit(RegistrationFullState.empty());
    });
    
  }
  
}
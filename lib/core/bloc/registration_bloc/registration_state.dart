part of 'registration_bloc.dart';



abstract class RegistrationState{
  const RegistrationState();
}

class RegistrationFullState {
  
  final String phoneNumber;
  final String? phoneNumberError;
  final String code;
  final String? codeError;
  const RegistrationFullState({
    required this.phoneNumber,
    required this.phoneNumberError,
    required this.code,
    required this.codeError
  });

  static  RegistrationFullState empty(){
    return RegistrationFullState(
      phoneNumber: "+1",
      phoneNumberError: null,
      code: "",
      codeError: null
    );
  }
  copyWith({
      String? phoneNumber,
      String? phoneNumberError,
      String? code,
      String? codeError,
    }){
    return RegistrationFullState(
      phoneNumber: phoneNumber??this.phoneNumber,
      phoneNumberError: phoneNumberError??this.phoneNumberError,
      code: code??this.code,
      codeError: codeError??this.codeError
    );
  }

}
import 'package:izzi_ride_2/core/models/social.dart';

class UserModel{
  int clienId;
  DateTime? dateOfBirth;
  String? photo;
  String name;
  String surname;
  String nickname;
  String gender;
  double rate;
  bool phoneConfirmed;
  bool emailConfirmed;
  bool passportConfirmed;
  DateTime? firstRegisterDate;
  List<Social>? socialPlatforms;
  UserModel({
    required this.clienId,
    required this.dateOfBirth,
    required this.gender,
    required this.name,
    required this.nickname,
    required this.photo,
    required this.surname,
    required this.rate,
    required this.phoneConfirmed,
    required this.emailConfirmed,
    required this.firstRegisterDate,
    required this.socialPlatforms,
    required this.passportConfirmed
  });
}
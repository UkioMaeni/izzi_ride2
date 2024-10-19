import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/core/models/response.dart';

abstract interface class TokenInterface{
  
  String? accessToken;
  String? get refreshToken;
  Future<String?> injectRefreshToken();
  Future<void> deleteRefreshToken();
  Future<void> setRefreshToken(String token);
  Future<void> deleteAccessToken();
  Future<CustomResponse<String>> refreshingToken();
}
import 'package:get_it/get_it.dart';

abstract interface class TokenInterface{
  
  String? get accessToken;
  String? get refreshToken;
  Future<void> injectRefreshToken();
  Future<void> deleteRefreshToken();
  Future<void> deleteAccessToken();
  Future<String> refreshingToken();
}
import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Token implements TokenInterface{
  @override
  String? accessToken;

  @override
  String? refreshToken;

  @override
  Future<void> deleteAccessToken()async {
    accessToken=null;
  }

  @override
  Future<void> deleteRefreshToken()async {
    final storage = await  GetIt.I.getAsync<SharedPreferences>();
    await storage.remove("refresh");
    refreshToken=null;
  }

  @override
  Future<void> injectRefreshToken() async {
    final storage = await  GetIt.I.getAsync<SharedPreferences>();
    refreshToken=  storage.getString("refresh");
  }
  
  @override
  Future<String> refreshingToken()async {
    return "error";
  }
  
}
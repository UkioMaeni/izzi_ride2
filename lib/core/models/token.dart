import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/core/http/token_http.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/core/models/response.dart';
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
  Future<void> setRefreshToken(String token)async {
    final storage = await  GetIt.I.getAsync<SharedPreferences>();
    await storage.setString("refresh",token);
    refreshToken=token;
  }
  @override
  Future<void> deleteRefreshToken()async {
    final storage = await  GetIt.I.getAsync<SharedPreferences>();
    await storage.remove("refresh");
    refreshToken=null;
  }

  @override
  Future<String?> injectRefreshToken() async {
    if(refreshToken!=null){
      return refreshToken!;
    }
    final storage = await  GetIt.I.getAsync<SharedPreferences>();
    refreshToken=  storage.getString("refresh");
    return refreshToken;
  }
  
  @override
  Future<CustomResponse<String>> refreshingToken()async {
    String? token = await injectRefreshToken();
    if(token==null) return CustomResponse<String>(data: "no_token");
    final result= await TokenHttp().refreshToken(token);
    if(result is CustomResponse<bool> && result.data==true){
      return CustomResponse<String>(data: "no");
    }
    return CustomResponse<String>(data: "error");
  }
  
}
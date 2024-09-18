import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/core/interfaces/app_info_interface.dart';
import 'package:izzi_ride_2/core/models/token.dart';
import 'package:izzi_ride_2/core/services/app_info-service.dart';
import 'package:izzi_ride_2/core/tools/dio_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
void setupGetIt(){
  GetIt.I.registerSingleton<AppInfoInterface>(AppInfoService());
  final dio=Dio();
  dio.interceptors.add(RefreshTokenInterceptor(dio: dio));
  GetIt.I.registerSingleton<Dio>(dio);
  GetIt.I.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  GetIt.I.registerSingletonWithDependencies<Token>(() => Token(),dependsOn: [SharedPreferences]);
  
}
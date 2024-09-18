import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class UserHttp{
  Dio dio = GetIt.I.get<Dio>();

  Future<bool> sendOtp()async{
    try {
      //dio.post("");
      return true;
    } catch (e) {
      return false;
    }
  }
}
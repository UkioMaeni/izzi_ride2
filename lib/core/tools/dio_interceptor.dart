import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/core/models/token.dart';



class RefreshTokenInterceptor extends Interceptor {
  final Dio dio;
  RefreshTokenInterceptor({required this.dio});
  
  
  List<Map<dynamic, dynamic>> failedRequests = [];
  bool isRefreshing = false;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    
    

    if ( err.response?.statusCode == 401) {
      
       final tokens=GetIt.I.get<TokenInterface>();

    if (tokens.refreshToken == null || tokens.refreshToken!.isEmpty) {
      return handler.reject(err);
    } 
      if (!isRefreshing) {
        isRefreshing = true;

        failedRequests.add({'err': err, 'handler': handler});

        try {
          final isOk = await tokens.refreshingToken();
          if(isOk.data=="no"){
            await retryFailedRequests();
          }else{
            releaseFailedRequests();
          }
          
        } catch (e) {
          
      }
      isRefreshing = false;
      failedRequests = [];
    }
   

      
    return handler.next(err);
    } else {
      // Adding errored request to the queue
      failedRequests.add({'err': err, 'handler': handler});
    }
    return handler.next(err);
  }
  releaseFailedRequests(){
    for (var element in failedRequests) {
      var exp= element["err"]as DioException;
      var handler= element['handler'] as ErrorInterceptorHandler;
      handler.reject(exp);

    }
  }
  Future<void> retryFailedRequests()async{
    for (var element in failedRequests) {
       var exp= element["err"]as DioException;
       var handler= element['handler'] as ErrorInterceptorHandler;
       final requestOptions = exp.requestOptions;
       if(requestOptions!=null){
        try {
          final result=  await dio.request(
            requestOptions.path, 
            data:  requestOptions.data,
            queryParameters: requestOptions.queryParameters,
            options: Options(method:  requestOptions.method),
          ); 
          return handler.resolve(result);
        } catch (e) {
         
         return handler.reject(exp);
        }
        
       }

    }
  }
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler)async {
    String? accessToken = GetIt.I.get<TokenInterface>().accessToken;
    if(accessToken==null){
      await GetIt.I.get<TokenInterface>().refreshingToken();
    }
    accessToken = GetIt.I.get<TokenInterface>().accessToken;
    options.headers.addEntries({
    //MapEntry("app_version","1.0.6"),
    MapEntry("Authorization",'Bearer ${accessToken}')
   });
    super.onRequest(options, handler);
  }

}

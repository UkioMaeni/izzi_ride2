import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/core/models/token.dart';



class RefreshTokenInterceptor extends Interceptor {
  final Dio dio;
  RefreshTokenInterceptor({required this.dio});
  
  
  List<Map<dynamic, dynamic>> failedRequests = [];
  bool isRefreshing = false;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    
    

    if ( err.response?.statusCode != 401) {
      return handler.next(err);
    }
    final tokens=GetIt.I.get<Token>();

    if (tokens.refreshToken == null || tokens.refreshToken!.isEmpty) {
      return handler.reject(err);
    } 
    if (!isRefreshing) {
      isRefreshing = true;

      failedRequests.add({'err': err, 'handler': handler});

      try {
        final isOk = await tokens.refreshingToken();
        if(isOk=="error"){
          await retryFailedRequests();
        }else{
          releaseFailedRequests();
        }
        
      } catch (e) {
        
      }

      isRefreshing = false;
      failedRequests = [];

    } else {
      // Adding errored request to the queue
      failedRequests.add({'err': err, 'handler': handler});
    }
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

}

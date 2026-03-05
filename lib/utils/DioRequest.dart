import 'package:dio/dio.dart';
import 'package:shop/Constants/Constants.dart';

class DioRequest {
    final _dio = Dio();

    //基础配置
    DioRequest(){
      _dio.options
          ..baseUrl = GlobalConstants.BASE_URL
          ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
          ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
          ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);

      _addInterceptor();
    }

    //添加拦截器
    void _addInterceptor(){
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (request,handler){
            handler.next(request);
          },
          onResponse: (response,handler){
            if(response.statusCode! >= 200 && response.statusCode! <300)
              {
                handler.next(response);
                return;
              }
            handler.reject(DioException(requestOptions: response.requestOptions));
          },
          onError: (error,handler){
            handler.reject(error);
          }
        )
      );
    }

    //网络请求
    Future<dynamic> get(String url,{Map<String,dynamic>? params}){
      return _handlerResponse(_dio.get(url,queryParameters: params));
    }

    //进一步处理返回结果的函数
    Future<dynamic> _handlerResponse(Future<Response<dynamic>> task) async{
      try{

        Response<dynamic> res = await task;
        final data = res.data as Map<String,dynamic>;

        if(data["code"] == GlobalConstants.SUCCESS_CODE){
          return data["result"];
        }

        throw Exception(data["msg"] ?? "加载数据异常");
      }catch(e){
        throw Exception(e);
      }
    }
}

//单例对象
final dioRequest = DioRequest();
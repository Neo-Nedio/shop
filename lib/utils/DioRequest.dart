import 'package:dio/dio.dart';
import 'package:shop/Constants/Constants.dart';
import 'package:shop/stores/TokenManager.dart';

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
            // 注入token
            if(tokenManager.get().isNotEmpty){
              request.headers = {
                "Authorization" : "Bearer ${tokenManager.get()}"
              };
            }

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
            handler.reject(
              DioException(
                  requestOptions: error.requestOptions,  // 保留原始请求信息(请求配置、URL、方法等)
                  message: error.response?.data["msg"] ?? ""  // 添加服务器返回的错误信息
              )
            );
          }
        )
      );
    }

    //网络请求
    Future<dynamic> get(String url,{Map<String,dynamic>? params}){
      return _handlerResponse(_dio.get(url,queryParameters: params));
    }

    Future<dynamic> post(String url, {Map<String,dynamic>? data}){
      return _handlerResponse(_dio.post(url,data: data));
    }

    //进一步处理返回结果的函数
    Future<dynamic> _handlerResponse(Future<Response<dynamic>> task) async{
      try{

        Response<dynamic> res = await task;
        final data = res.data as Map<String,dynamic>;

        if(data["code"] == GlobalConstants.SUCCESS_CODE){
          return data["result"];
        }

        throw DioException(
            requestOptions: res.requestOptions,
            message:  data["msg"] ?? "加载数据异常");
      }catch(e){
        rethrow;
      }
    }
}

/*拦截器本质上是一个中间件管道，而不是请求的终点。在 onError 中使用 handler.reject() 时，
实际上是在继续传递错误，而不是终止流程。这个被传递的错误会让 _dio.post() 返回的 Future 以错误状态完成，
然后这个 Future 被 _handlerResponse 中的 await 等待，从而进入 catch 代码块。
通过创建新的 DioException 并添加服务器返回的 msg 信息，
既保留了原始错误的请求信息，又增强了错误提示，同时保持了错误类型不变，让整个错误处理链更加完善。
这种"拦截器处理 HTTP 层错误，_handlerResponse 处理业务层错误"的分层设计正是推荐的架构模式。*/



//单例对象
final dioRequest = DioRequest();
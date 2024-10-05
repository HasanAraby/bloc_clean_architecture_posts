import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Content-type'] = 'application/json; charset=UTF-8';
    super.onRequest(options, handler);
  }
}

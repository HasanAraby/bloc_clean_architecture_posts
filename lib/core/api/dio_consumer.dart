import 'package:bloc_clean_architecture_posts/core/api/api_consumer.dart';
import 'package:bloc_clean_architecture_posts/core/constants/end_points.dart';
import 'package:bloc_clean_architecture_posts/core/constants/strings.dart';
import 'package:bloc_clean_architecture_posts/core/errors/failure.dart';
import 'package:dio/dio.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.options.sendTimeout = const Duration(seconds: 20);
    // dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      error: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
    ));
  }
  @override
  Future<dynamic> get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await dio.get(path, data: data, queryParameters: queryParameters);
      return response.data;
    } catch (e) {
      throw ServerException(errMessage: Strings.serverExcMessage);
    }
  }

  @override
  Future<dynamic> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      final response = await dio.post(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters);
      return response.data;
    } catch (e) {
      print('wrong is here');
      throw ServerException(errMessage: Strings.serverExcMessage);
    }
  }

  @override
  Future<dynamic> patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      final response = await dio.put(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters);
      return response.data;
    } catch (e) {
      throw ServerException(errMessage: Strings.serverExcMessage);
    }
  }

  @override
  Future<dynamic> delete(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false}) async {
    try {
      final response = await dio.delete(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParameters);
      return response.data;
    } catch (e) {
      throw ServerException(errMessage: Strings.serverExcMessage);
    }
  }
}

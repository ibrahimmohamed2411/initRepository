// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class AppInterceptors extends Interceptor {
  
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    // String? token = await userLocalDataSource.getUserToken();
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer ${token}';
    // }
    // String lang = await langLocalDataSource.getSavedLang();
    // options.headers['lang'] = lang;
    // options.headers[AppStrings.contentType] = AppStrings.applicationJson;
    // options.headers['Accept'] = AppStrings.applicationJson;

    // options.headers['apiPassword'] = '12345678';

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}

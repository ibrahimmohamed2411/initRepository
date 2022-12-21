// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:helloworld/core/api/status_code.dart';
import 'package:helloworld/locator/locator.dart';
import 'package:injectable/injectable.dart';
import '../error/exceptions.dart';
import 'api_consumer.dart';
import 'app_interceptors.dart';
import 'end_points.dart';

@LazySingleton(as: ApiConsumer)
class DioConsumer implements ApiConsumer {
  final Dio client;
  DioConsumer({
    required this.client,
  }) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(locator<AppInterceptors>());

    if (kDebugMode) client.interceptors.add(locator<LogInterceptor>());
  }

  @override
  Future delete(String url) {
    throw UnimplementedError();
  }

  @override
  Future get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(url, queryParameters: queryParameters);
      return _handelResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(String url,
      {Map<String, dynamic>? body,
      bool formDataIsEnabled = false,
      Map<String, dynamic>? queryParameters}) async {
    // try {
    final response = await client.post(url,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body);
    if (response.statusCode == 201)
      return _handelResponseAsJson(response);
    else {
      final errorMessage = json.decode(response.data);
      throw ServerException(msg: errorMessage['message']);
    }
    // throw ServerException(msg: response.data['message']);
    // } on DioError catch (error) {
    // print('Dio Error ${error.toString()}');
    // _handleDioError(error);
    // throw ServerException(msg: error.response!.statusMessage);
    // }
  }

  @override
  Future put(String url,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await client.put(url, queryParameters: queryParameters, data: body);
      return _handelResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handelResponseAsJson(Response<dynamic> response) {
    return json.decode(response.data.toString());
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:

      case DioErrorType.sendTimeout:

      case DioErrorType.receiveTimeout:
        throw FetchDataException();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw UnauthorizedException();
          case StatusCode.notFound:
            throw NotFoundException();
          case StatusCode.conflict:
            throw ConflictException();
          case StatusCode.internalServerError:
            throw InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException();
    }
  }
}

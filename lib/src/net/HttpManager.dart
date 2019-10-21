import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vincent_flutter/src/common/DataResult.dart';

import 'HTTPCode.dart';
import 'interceptors/ErrorInterceptor.dart';
import 'interceptors/HeaderInterceptor.dart';
import 'interceptors/LogInterceptor.dart';
import 'interceptors/ResponseInterceptor.dart';
import 'interceptors/TokenInterceptor.dart';

///http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio _dio = new Dio(); // 使用默认配置

  final TokenInterceptors _tokenInterceptors = new TokenInterceptors();

  factory HttpManager() => _getInstance();

  static HttpManager get instance => _getInstance();
  static HttpManager _instance;

  HttpManager._internal() {
    _dio.interceptors.add(new HeaderInterceptors());
    _dio.interceptors.add(_tokenInterceptors);
    _dio.interceptors.add(new LogsInterceptors());
    _dio.interceptors.add(new ErrorInterceptors(_dio));
    _dio.interceptors.add(new ResponseInterceptors());
  }

  static HttpManager _getInstance() {
    if (_instance == null) {
      _instance = new HttpManager._internal();
    }
    return _instance;
  }

  request(url, params, Options option, {noTip = false}) async {
    option = option ?? new Options(method: "get");
    option.contentType = option.contentType ?? ContentType.parse("application/x-www-form-urlencoded");
    option.responseType = ResponseType.json;

    _resultError(DioError e) {
      Response res = e.response != null ? e.response : new Response(statusCode: 666);
      if (e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        res.statusCode = HTTPCode.NETWORK_TIMEOUT;
      }
      return new DataResult(false, HTTPCode.errorHandleFunction(res.statusCode, e.message), res.statusCode.toString());
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      return _resultError(e);
    }
    if (response.data is DioError) {
      return _resultError(response.data);
    }
    return response.data;
  }
}

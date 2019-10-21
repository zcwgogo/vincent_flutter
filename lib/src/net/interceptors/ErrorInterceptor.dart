import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:vincent_flutter/src/common/DataResult.dart';
import '../HTTPCode.dart';

class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptors(this._dio);

  @override
  onRequest(RequestOptions options) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(new DataResult(false, HTTPCode.errorHandleFunction(HTTPCode.NETWORK_ERROR, ""), HTTPCode.NETWORK_ERROR));
    }
    return options;
  }
}

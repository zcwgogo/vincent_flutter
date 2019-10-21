import 'dart:io';

import "package:dio/dio.dart";

class HeaderInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    options.connectTimeout = 15000;
    options.headers = options.headers ?? {};
    options.headers["X-Requested-With"] = "XMLHttpRequest";
    return options;
  }
}

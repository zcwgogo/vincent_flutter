import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:vincent_flutter/src/common/config/AppConfig.dart';
import 'package:vincent_flutter/src/storage/LocalStorage.dart';

class TokenInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    options.headers["Authorization"] = await getAuthorization();
    return options;
  }

  @override
  onResponse(Response response) async {
    return response;
  }

  ///获取授权token
  getAuthorization() async {
    String token = await LocalStorage.get(AppConfig.TOKEN_KEY);
    if (token == null) {
      String basic = await LocalStorage.get(AppConfig.STORAGE_CODE_USER_INFO);
      if (basic == null) {//for login
        return "";
      }
      String str = json.decode(basic)["token"];
      return "Bearer $str";
    } else {
      return token;
    }
  }
}

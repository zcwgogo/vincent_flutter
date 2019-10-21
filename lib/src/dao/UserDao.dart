import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:vincent_flutter/src/common/DataResult.dart';
import 'package:vincent_flutter/src/common/config/AppConfig.dart';
import 'package:vincent_flutter/src/model/User.dart';
import 'package:vincent_flutter/src/net/Address.dart';
import 'package:vincent_flutter/src/net/HttpManager.dart';
import 'package:vincent_flutter/src/storage/LocalStorage.dart';
import 'package:vincent_flutter/view/store/user_redux.dart';
import 'package:vincent_flutter/view/utils/VCommonUtils.dart';

class UserDao {
  static login(userName, password, lang,store) async {
    Map requestParams = {
      'lang': lang,
      'username': userName,
      'password': password,
    };
    DataResult result = await HttpManager.instance.request(Address.login_url, requestParams, new Options(method: "post"));
    if (result.success) {
      String _token = 'Bearer ' + result.data["token"];
      await LocalStorage.save(AppConfig.TOKEN_KEY, _token);
      await LocalStorage.save(AppConfig.STORAGE_CODE_USER_INFO, json.encode(result.data));
      store.dispatch(new UpdateUserAction(User.fromMap(result.data)));
    }
    return result;
  }

  static refreshToken() async {
    DataResult result = await HttpManager.instance.request(Address.refresh_token_url, {}, null);
    if (result.success && result.data["token"] != null) {
      String _token = 'Bearer ' + result.data["token"];
      await LocalStorage.save(AppConfig.TOKEN_KEY, _token);
      //TODO to update user info
    } else {
      result.success = false;
    }
    return result;
  }

  ///获取本地登录用户信息
  static Future<Map> getUserInfoLocal() async {
    var userText = await LocalStorage.get(AppConfig.STORAGE_CODE_USER_INFO);
    if (userText != null) {
      var userMap = json.decode(userText);
      return userMap;
    } else {
      return {};
    }
  }

  ///获取本地登录用户信息
  static Future<User> getUser() async {
    var userText = await LocalStorage.get(AppConfig.STORAGE_CODE_USER_INFO);
    if (userText != null) {
      var userMap = json.decode(userText);
      return User.fromMap(userMap);
    } else {
      return User.empty();
    }
  }

  static clearAll(Store store) async {
    LocalStorage.remove(AppConfig.STORAGE_CODE_USER_INFO);
    LocalStorage.remove(AppConfig.TOKEN_KEY);
    store.dispatch(new UpdateUserAction(User.empty()));
  }

  static Future<DataResult> initUserInfo(Store store) async {
    var token = await LocalStorage.get(AppConfig.TOKEN_KEY);
    var res = await getUserInfoLocal();
    if (!ObjectUtil.isEmptyString(token)) {
      store.dispatch(UpdateUserAction(User.fromMap(res)));
    }
    String themeIndex = await LocalStorage.get(AppConfig.STORAGE_CODE_THEME_COLOR);
    if (themeIndex != null && themeIndex.length != 0) {
      VCommonUtils.pushTheme(store, int.parse(themeIndex));
    }
    String localeIndex = await LocalStorage.get(AppConfig.STORAGE_CODE_LOCALE);
    if (localeIndex != null && localeIndex.length != 0) {
      VCommonUtils.changeLocale(store, int.parse(localeIndex));
    }
    return new DataResult(!ObjectUtil.isEmptyString(token), "", res);
  }
}

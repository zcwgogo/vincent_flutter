import 'package:flutter/material.dart';
import 'package:vincent_flutter/src/model/User.dart';
import 'package:vincent_flutter/view/store/locale_redux.dart';
import 'package:vincent_flutter/view/store/theme_redux.dart';
import 'package:vincent_flutter/view/store/user_redux.dart';

class VState {
  ///用户信息
  User userInfo;

  ///主题数据
  ThemeData themeData;

  ///语言
  Locale locale;

  ///当前手机平台默认语言
  Locale platformLocale;

  ///构造方法
  VState({this.userInfo, this.themeData, this.locale});
}

///创建 Reducer
///源码中 Reducer 是一个方法 typedef State Reducer<State>(State state, dynamic action);
///我们自定义了 appReducer 用于创建 store
VState appReducer(VState state, action) {
  return VState(
    ///通过 UserReducer 将 GSYState 内的 userInfo 和 action 关联在一起
    userInfo: userReducer(state.userInfo, action),

    ///通过 ThemeDataReducer 将 GSYState 内的 themeData 和 action 关联在一起
    themeData: themeDataReducer(state.themeData, action),

    ///通过 LocaleReducer 将 GSYState 内的 locale 和 action 关联在一起
    locale: localeReducer(state.locale, action),
  );
}
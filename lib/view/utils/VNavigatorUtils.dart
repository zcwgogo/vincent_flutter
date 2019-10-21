import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/home/HomePage.dart';
import 'package:vincent_flutter/view/login/Login.dart';
import 'package:vincent_flutter/view/page/user/user_list.dart';

class VNavigatorUtils {
  static Future<T> showVWDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(

              ///不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1),
              child: new SafeArea(child: builder(context)));
        });
  }

  static Widget pageContainer(widget) {
    return MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1), child: widget);
  }

  static navigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) => pageContainer(widget)));
  }

  static void goHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.sName);
  }

  static void goLoginPage(BuildContext context) {
    Navigator.pushReplacementNamed(context, LoginPage.sName);
  }

  static void goSearchPage(BuildContext context) {
//    return navigatorRouter(context, new SearchPage());
  }

  static void goUserListPage(BuildContext context) {
    return navigatorRouter(context, new UserList());
  }
}

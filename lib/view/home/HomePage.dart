import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/page/menu/menu_page.dart';
import 'package:vincent_flutter/view/page/message/message_page.dart';
import 'package:vincent_flutter/view/page/mine/mine_page.dart';
import 'package:vincent_flutter/view/style/VCommonColors.dart';
import 'package:vincent_flutter/view/style/VIconConstant.dart';
import 'package:vincent_flutter/view/utils/VMessageUtils.dart';
import 'package:vincent_flutter/view/utils/VNavigatorUtils.dart';
import 'package:vincent_flutter/view/widget/vw_tab_bar.dart';
import 'package:vincent_flutter/view/widget/vw_title_bar.dart';
import 'package:vincent_flutter/view/page/newest/newest_list.dart';
import 'HomeDrawer.dart';

class HomePage extends StatelessWidget {
  static final String sName = "view.home";

  /// 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    ///如果是 android 回到桌面
    if (Platform.isAndroid) {
    }
    return Future.value(false);
  }

  _renderTab(icon, text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[new Icon(icon, size: 16.0), new Text(text)],
      ),
    );
  }

  // This view.widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(VIconConstant.MAIN_HOME, VMessageUtils.getLocale(context,"menu newest")),
      _renderTab(VIconConstant.MAIN_MENU, VMessageUtils.getLocale(context,"menu all")),
      _renderTab(VIconConstant.MAIN_MESSAGE, VMessageUtils.getLocale(context,"menu message")),
      _renderTab(VIconConstant.MAIN_MY, VMessageUtils.getLocale(context,"menu.mine")),
    ];

    ///增加返回按键监听
    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: new VWTabBar(
        drawer:  HomeDrawer(),
        type: VWTabBar.BOTTOM_TAB,
        tabItems: tabs,
        tabViews: [
           NewestList(),
           MenuPage(),
           MessageList(),
          MinePage()
        ],
        backgroundColor: VCommonColors.primarySwatch,
        indicatorColor: Color(VCommonColors.white),
        title: VWTitleBar(
          VMessageUtils.getLocale(context, "app.title"),
          iconData: VIconConstant.MAIN_SEARCH,
          needRightLocalIcon: true,
          onPressed: () {
            VNavigatorUtils.goSearchPage(context);
          },
        ),
      ),
    );
  }
}

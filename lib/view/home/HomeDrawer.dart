import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:package_info/package_info.dart';
import 'package:vincent_flutter/src/dao/ReposDao.dart';
import 'package:vincent_flutter/src/dao/UserDao.dart';
import 'package:vincent_flutter/src/model/User.dart';
import 'package:vincent_flutter/view/store/VState.dart';
import 'package:vincent_flutter/view/style/VCommonColors.dart';
import 'package:vincent_flutter/view/style/VCommonStyles.dart';
import 'package:vincent_flutter/view/style/VIconConstant.dart';
import 'package:vincent_flutter/view/utils/VCommonUtils.dart';
import 'package:vincent_flutter/view/utils/VMessageUtils.dart';
import 'package:vincent_flutter/view/utils/VNavigatorUtils.dart';
import 'package:vincent_flutter/view/widget/vw_flex_button.dart';
import 'package:vincent_flutter/view/widget/vw_network_cache_image.dart';

class HomeDrawer extends StatelessWidget {
  showAboutDialog(BuildContext context, String versionName) {
    versionName ??= "Null";
    VNavigatorUtils.showVWDialog(
        context: context,
        builder: (BuildContext context) => AboutDialog(
              applicationName: VMessageUtils.getLocale(context, "app.name"),
              applicationVersion: VMessageUtils.getLocale(context, "app.version"),
              applicationIcon: new Image(image: new AssetImage(VIconConstant.DEFAULT_USER_ICON), width: 50.0, height: 50.0),
              applicationLegalese: "http://bloomsoft.cn",
            ));
  }

  showThemeDialog(BuildContext context, Store store) {
    List<String> list = [VMessageUtils.getLocale(context, "主题1")];
    VCommonUtils.showCommitOptionDialog(context, list, (index) {}, colorList: VCommonUtils.getThemeListColor());
  }

  showLanguageDialog(BuildContext context, Store store) {
    List<String> list = [
      VMessageUtils.getLocale(context, "app.lang.zh"),
      VMessageUtils.getLocale(context, "app.lang.en"),
    ];
    VCommonUtils.showCommitOptionDialog(context, list, (index) {}, height: 150.0);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: new StoreBuilder<VState>(
        builder: (context, store) {
          User user = store.state.userInfo;

          return new Drawer(
            ///侧边栏按钮Drawer
            child: new Container(
              ///默认背景
              color: store.state.themeData.primaryColor,
              child: new SingleChildScrollView(
                ///item 背景
                child: Container(
                  constraints: new BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                  child: new Material(
                    color: Color(VCommonColors.white),
                    child: new Column(children: <Widget>[
                      new UserAccountsDrawerHeader(
                        //Material内置控件
                        accountName: new Text(
                          user.account ?? "---",
                          style: VCommonStyles.largeTextWhite,
                        ),
                        accountEmail: new Text(
                          user.email ?? user.name ?? "---",
                          style: VCommonStyles.normalTextLight,
                        ),
                        currentAccountPicture: new GestureDetector(
                          onTap: () {},
                          child: new CircleAvatar(
                            backgroundImage: VWNetworkCacheImage(user.avatar ?? VIconConstant.DEFAULT_REMOTE_PIC),
                          ),
                        ),
                        decoration: new BoxDecoration(
                          color: store.state.themeData.primaryColor,
                        ),
                      ),
                      new ListTile(
                          title: new Hero(
                              tag: "home_user_info",
                              child: new Material(
                                  color: Colors.transparent,
                                  child: new Text(
                                    VMessageUtils.getLocale(context, "home.menu.theme"),
                                    style: VCommonStyles.normalTextBold,
                                  ))),
                          onTap: () {
                            print("tap home_user_info");
                          }),
                      new ListTile(
                          title: new Text(
                            VMessageUtils.getLocale(context, "home.menu.profile"),
                            style: VCommonStyles.normalText,
                          ),
                          onTap: () {
                            showThemeDialog(context, store);
                          }),
                      new ListTile(
                          title: new Text(
                            VMessageUtils.getLocale(context,"home.menu.lang"),
                            style: VCommonStyles.normalText
                          ),
                          onTap: () {
                            showLanguageDialog(context, store);
                          }),
                      new ListTile(
                          title: new Text(
                            VMessageUtils.getLocale(context,"home.menu.update"),
                            style: VCommonStyles.normalText
                          ),
                          onTap: () {
                            ReposDao.getNewsVersion(context, true);
                          }),
                      new ListTile(
                          title: new Text(
                            VMessageUtils.getLocale(context,"home.menu.about"),
                            style: VCommonStyles.normalText
                          ),
                          onTap: () {
                            PackageInfo.fromPlatform().then((value) {
                              print(value);
                              showAboutDialog(context, value.version);
                            });
                          }),
                      new ListTile(
                          title: new VWFlexButton(
                            text:  VMessageUtils.getLocale(context,"home.menu.logout"),
                            color: Colors.redAccent,
                            textColor: Color(VCommonColors.textWhite),
                            onPress: () {
                              UserDao.clearAll(store);
                              VNavigatorUtils.goLoginPage(context);
                            },
                          ))
                    ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

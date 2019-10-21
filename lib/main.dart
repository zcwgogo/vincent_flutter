import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vincent_flutter/src/dao/UserDao.dart';
import 'package:vincent_flutter/src/model/User.dart';
import 'package:vincent_flutter/view/home/HomePage.dart';
import 'package:vincent_flutter/view/home/welcome_page.dart';
import 'package:vincent_flutter/view/localization/v_localizations_delegate.dart';
import 'package:vincent_flutter/view/login/Login.dart';
import 'package:vincent_flutter/view/store/VState.dart';
import 'package:vincent_flutter/view/style/VCommonColors.dart';
import 'package:vincent_flutter/view/utils/VCommonUtils.dart';
import 'package:vincent_flutter/view/utils/VNavigatorUtils.dart';
import 'package:vincent_flutter/vw_localizations.dart';

void main() => runApp(new Main());

class Main extends StatelessWidget {
  Main({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = VCommonUtils.getThemeData(VCommonColors.primarySwatch);
    final store = new Store<VState>(appReducer,
        initialState: new VState(userInfo: User.empty(), locale: Locale('zh', 'CH'), themeData: theme));

    return new StoreProvider(
      store: store,
      child: new StoreBuilder<VState>(builder: (context, store) {
        return new MaterialApp(
            title: 'Startup Name Generator',
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              VLocalizationsDelegate.delegate
            ],
            theme: theme,
            routes: {
              WelcomePage.sName: (context) {
                return WelcomePage();
              },
              HomePage.sName: (context) {
                return new VWLocalizations(child: VNavigatorUtils.pageContainer(new HomePage()));
              },
              LoginPage.sName: (context) {
                return new VWLocalizations(child: VNavigatorUtils.pageContainer(new LoginPage()));
              },
            });
      }),
    );
  }
}

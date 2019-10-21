import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vincent_flutter/src/dao/UserDao.dart' ;
import 'package:vincent_flutter/view/store/VState.dart';
import 'package:vincent_flutter/view/style/VCommonColors.dart';
import 'package:vincent_flutter/view/utils/VNavigatorUtils.dart';

class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      //FlareActor//

      return;
    }
    hadInit = true;
    Store<VState> store = StoreProvider.of(context);
    new Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      UserDao.initUserInfo(store).then((result) {
        if (result.success) {
          VNavigatorUtils.goHomePage(context);
        } else {
          VNavigatorUtils.goLoginPage(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<VState>(
      builder: (context, store) {
        double size = 200;
        return new Container(
          color: Color(VCommonColors.white),
          child: Stack(
            children: <Widget>[
              new Center(
                child: new Image(image: new AssetImage('assets/images/welcome.png')),
              ),
              new Align(
                alignment: Alignment.bottomCenter,
                child: new Container(
                  width: size,
                  height: size,
                  child: new FlareActor("assets/animations/flare_flutter_logo.flr",
                      alignment: Alignment.topCenter, fit: BoxFit.fill, animation: "Placeholder"),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}


import 'dart:async';
import 'package:vincent_flutter/src/dao/UserDao.dart';
import 'package:vincent_flutter/src/net/HTTPCode.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vincent_flutter/view/utils/VCommonUtils.dart';
import 'package:vincent_flutter/view/utils/VMessageUtils.dart';
import 'package:vincent_flutter/view/utils/VNavigatorUtils.dart';
import 'view/event/index.dart';
import 'package:redux/redux.dart';
import 'view/event/http_error_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vincent_flutter/view/store/VState.dart';

class VWLocalizations extends StatefulWidget {
  final Widget child;

  VWLocalizations({Key key, this.child}) : super(key: key);

  @override
  State<VWLocalizations> createState() {
    return new _VLocalizations();
  }
}

class _VLocalizations extends State<VWLocalizations> {
  StreamSubscription stream;

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<VState>(builder: (context, store) {
      ///通过 StoreBuilder 和 Localizations 实现实时多语言切换
      return new Localizations.override(
        context: context,
        locale: store.state.locale,
        child: widget.child,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    stream =eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  ///网络错误提醒
  errorHandleFunction(int code, message) {
    switch (code) {
      case HTTPCode.NETWORK_ERROR:
        Fluttertoast.showToast(
            msg: VMessageUtils.getLocale(context,"network.error"));
        break;
      case 401:
        Fluttertoast.showToast(
            msg: VMessageUtils.getLocale(context,"network.error.401"));
        break;
      case 403:
        Fluttertoast.showToast( msg: VMessageUtils.getLocale(context,"network.error.403"));
        VCommonUtils.showLoadingDialogTxt(context, VMessageUtils.getLocale(context,"network.login.relogin"));
        UserDao.refreshToken().then((result){
          Navigator.pop(context);
          if(!result.success){
            UserDao.clearAll( StoreProvider.of(context));
            VNavigatorUtils.goLoginPage(context);
          }
        });
        break;
      case 404:
        Fluttertoast.showToast(
            msg: VMessageUtils.getLocale(context,"network.error.404"));
        break;
      case HTTPCode.NETWORK_TIMEOUT:
      //超时
        Fluttertoast.showToast(
            msg: VMessageUtils.getLocale(context,"network.error.timeout"));
        break;
      default:
        Fluttertoast.showToast(msg: message);
        break;
    }
  }
}

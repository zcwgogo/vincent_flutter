import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vincent_flutter/view/style/VCommonStyles.dart';
import 'package:vincent_flutter/view/style/VIconConstant.dart';
import 'package:vincent_flutter/view/utils/VMessageUtils.dart';

import 'vw_pull_load_control.dart';

abstract class PullLoadStateBase {
  IndexedWidgetBuilder getItemBuilder();

  VWPullLoadControl getPullLoadControl();

  ScrollController getScrollController();

  Future<void> requestRefresh({Map param, String order, callBack}) async {
    getPullLoadControl().requestRefresh(param: param, order: order).then((result) {
      if (callBack != null) {
        callBack();
      }
      refreshState(() => {});
    });
  }

  Future<void> requestLoadMore({Map param, String order}) async {
    getPullLoadControl().requestLoadMore(param: param, order: order).then((result) {
      refreshState(() => {});
    });
  }

  void refreshState(callBack);

  void initWidgetState() {
    getPullLoadControl().needLoadMore?.addListener(() {
      try {
        Future.delayed(Duration(seconds: 2), () {
          getScrollController().notifyListeners();
        });
      } catch (e) {
        LogUtil.e(e);
      }
    });
    getScrollController().addListener(() {
      if (getScrollController().position.pixels == getScrollController().position.maxScrollExtent) {
        if (getPullLoadControl().needLoadMore.value) {
          requestLoadMore();
        }
      }
    });
  }

  getListCount() {
    var control = getPullLoadControl();
    if (control.needHeader) {
      return (control.dataList.length > 0) ? control.dataList.length + 2 : control.dataList.length + 1;
    } else {
      if (control.dataList.length == 0) {
        return 1;
      }
      return (control.dataList.length > 0) ? control.dataList.length + 1 : control.dataList.length;
    }
  }

  getItem(BuildContext context, int index) {
    var control = getPullLoadControl();
    if (!control.needHeader && index == control.dataList.length && control.dataList.length != 0) {
      return _buildProgressIndicator(context);
    } else if (control.needHeader && index == getListCount() - 1 && control.dataList.length != 0) {
      return _buildProgressIndicator(context);
    } else if (!control.needHeader && control.dataList.length == 0) {
      return _buildEmpty(context);
    } else {
      return getItemBuilder()(context, index);
    }
  }

  Widget buildWidget(BuildContext context) {
    return new RefreshIndicator(
      onRefresh: requestRefresh,
      child: new ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return getItem(context, index);
          },
          itemCount: getListCount(),
          controller: getScrollController()),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height - 100,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: new Image(image: new AssetImage(VIconConstant.DEFAULT_USER_ICON), width: 70.0, height: 70.0),
          ),
          Container(
            child: Text(VMessageUtils.getLocale(context, "widget.pull.empty"), style: VCommonStyles.normalText),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    Widget bottomWidget = (getPullLoadControl().needLoadMore.value)
        ? new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            new SpinKitRotatingCircle(color: Theme.of(context).primaryColor),
            new Container(
              width: 5.0,
            ),
            new Text(
              VMessageUtils.getLocale(context, "widget.pull.more"),
              style: TextStyle(
                color: Color(0xFF121917),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ])
        : new Container();
    return new Padding(
      padding: const EdgeInsets.all(20.0),
      child: new Center(
        child: bottomWidget,
      ),
    );
  }

  void widgetDispose() {
    getScrollController().dispose();
  }
}

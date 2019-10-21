import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/widget/pull/pull_load_widgetBase.dart';

import 'pull_load_state_base.dart';
import 'vw_pull_load_control.dart';

class VWPullLoad extends StatefulWidget with PullLoadWidgetBase {
  final IndexedWidgetBuilder _itemBuilder;
  final VWPullLoadControl _control;
  final ScrollController _scrollController = new ScrollController();

  VWPullLoad(this._control, this._itemBuilder);

  @override
  ScrollController getScrollController() {
    return _scrollController;
  }

  @override
  _VWPullLoadState createState() {
    return _VWPullLoadState(this._control, this._itemBuilder, this._scrollController);
  }
}

class _VWPullLoadState extends State<VWPullLoad> with PullLoadStateBase {
  final IndexedWidgetBuilder _itemBuilder;
  VWPullLoadControl _control;
  ScrollController _scrollController;

  _VWPullLoadState(this._control, this._itemBuilder, this._scrollController);

  @override
  VWPullLoadControl getPullLoadControl() {
    return _control;
  }

  @override
  ScrollController getScrollController() {
    return _scrollController;
  }

  @override
  IndexedWidgetBuilder getItemBuilder() {
    return _itemBuilder;
  }

  @override
  void refreshState(callBack) {
    setState(callBack);
  }

  @override
  void dispose() {
    super.widgetDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return super.buildWidget(context);
  }

  @override
  void initState() {
    super.initWidgetState();
    super.initState();
  }
}

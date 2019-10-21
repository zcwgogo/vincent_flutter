import 'package:flutter/material.dart';

abstract class PullLoadWidgetBase {
  ScrollController getScrollController();

  refreshData() {
    new Future.delayed(const Duration(milliseconds: 1000), () {
      getScrollController().jumpTo(-100);
      return true;
    });
  }
}

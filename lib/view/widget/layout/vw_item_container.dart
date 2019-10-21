import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/utils/VNavigatorUtils.dart';

import 'vw_widget_item.dart';

class WidgetItemContainer extends StatelessWidget {
  final int columnCount; //一行几个
  final List<dynamic> categories;
  final bool isWidgetPoint;

  // 所有的可用demos;
  final List widgetDemosList = _initWidget();

  WidgetItemContainer({Key key, @required this.categories, @required this.columnCount, @required this.isWidgetPoint})
      : super(key: key);

  static _initWidget() {
    List result = [];
    result.add("用户");
    return result;
  }

  List<Widget> _buildColumns(context) {
    List<Widget> _listWidget = [];
    List<Widget> _listRows = [];
    int addI;
    for (int i = 0, length = categories.length; i < length; i += columnCount) {
      _listRows = [];
      for (int innerI = 0; innerI < columnCount; innerI++) {
        addI = innerI + i;
        if (addI < length) {
          dynamic item = categories[addI];
          _listRows.add(
            Expanded(
              flex: 1,
              child: WidgetItem(
                title: item.name,
                onTap: () {
                  VNavigatorUtils.goUserListPage(context);
                },
                index: addI,
                totalCount: length,
                rowLength: columnCount,
                textSize: isWidgetPoint ? 'middle' : 'small',
              ),
            ),
          );
        } else {
          _listRows.add(
            Expanded(
              flex: 1,
              child: Container(),
            ),
          );
        }
      }
      _listWidget.add(
        Row(
          children: _listRows,
        ),
      );
    }
    return _listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildColumns(context),
    );
  }
}

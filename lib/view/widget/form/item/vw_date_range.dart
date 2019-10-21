import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/widget/form/item/date_pick_base.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item_option.dart';

class VWDateRange extends  VWFormItem {
  @required
  final VWFormItemOption option;
  @required
  final DatePickType type;

  VWDateRange({this.option, this.type});

  @override
  Object getText() {
    return option.text;
  }
  @override
  void reset() {
  }
  @override
  VWFormItemOption getOption() {
    return option;
  }

  void generateText(DateTime start, DateTime end) {
    String s = DateUtil.getDateStrByDateTime(start, format: DateFormat.YEAR_MONTH_DAY);
    String e = DateUtil.getDateStrByDateTime(end, format: DateFormat.YEAR_MONTH_DAY);
    option.text = json.encode(<String>[s, e]);
  }

  @override
  Widget buildItem(BuildContext context) {
    DateTime start = DateTime.now();
    DateTime end = DateTime.now().add(new Duration(days: 1));

    VWFormItemOption startOption = VWFormItemOption.empty();
    startOption.onChange = (DateTime date) {
      start = date;
      generateText(start, end);
    };
    VWFormItemOption endOption = VWFormItemOption.empty();
    endOption.onChange = (DateTime date) {
      end = date;
      generateText(start, end);
    };

    return ListTile(
        title: new Text(option.label),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DatePickBase(option: startOption, value: DateTime.now(), start: DateTime(2015, 1), end: end, type: this.type),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
            ),
            DatePickBase(option: endOption, value: end, start: start, end: DateTime(2101), type: this.type)
          ],
        ));
  }
}

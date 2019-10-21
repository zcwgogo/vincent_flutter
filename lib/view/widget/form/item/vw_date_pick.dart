import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/widget/form/item/date_pick_base.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item_option.dart';

class VWDatePick extends  VWFormItem {
  @required
  final VWFormItemOption option;
  final DateTime value;
  final DateTime start;
  final DateTime end;
  @required
  final DatePickType type;

  VWDatePick({this.option, this.value, this.start, this.end, this.type});

  @override
  Widget buildItem(BuildContext context) {
    this.option.onChange = (DateTime date) {
      this.option.text = DateUtil.getDateStrByDateTime(date, format: DateFormat.YEAR_MONTH_DAY);
    };
    return ListTile(
        title: new Text(option.label),
        subtitle: DatePickBase(option: this.option, value: this.value, start: this.start, end: this.end, type: this.type));
  }

  @override
  Object getText() {
    return this.option.text;
  }
  @override
  VWFormItemOption getOption() {
    return option;
  }
  @override
  void reset() {
  }
}

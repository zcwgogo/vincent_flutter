import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item_option.dart';

class DatePickBase extends StatefulWidget  {
  @required
  final VWFormItemOption option;
  final DateTime value;
  final DateTime start;
  final DateTime end;
  @required
  final DatePickType type;

  DatePickBase({this.option, this.value, this.start, this.end, this.type});

  @override
  State<StatefulWidget> createState() => _DatePickBaseState(this.option, this.value, this.start, this.end, this.type);

}

class _DatePickBaseState extends State<DatePickBase> {
  final VWFormItemOption option;
  DateTime value;
  final DateTime start;
  final DateTime end;
  final DatePickType type;

  _DatePickBaseState(this.option, this.value, this.start, this.end, this.type);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(context: context, initialTime: this.value ?? TimeOfDay.now());
    if (picked != null) {
      this.option.onChange(picked);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: this.value ?? DateTime.now(),
        firstDate: this.start ?? DateTime(2015, 1),
        lastDate: this.end ?? DateTime(2101));
    setState(() {
      this.value = picked;
      if(this.option!=null){
        this.option.onChange(picked);
      }
    });
  }

  DateTime getDateTime() {
    return value;
  }

  @override
  Widget build(BuildContext context) {
    String text = value != null ? DateUtil.getDateStrByDateTime(value, format: DateFormat.YEAR_MONTH_DAY) : "请选择";
    return RaisedButton(
      child: Text(text),
      onPressed: () {
        if (DatePickType.TIME == this.type) {
          _selectTime(context);
        } else {
          _selectDate(context);
        }
      },
    );
  }
}


enum DatePickType {
  MONTH,
  DAY,
  DATE,
  TIME,
}

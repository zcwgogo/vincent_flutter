import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item_option.dart';
import 'package:vincent_flutter/view/widget/layout/vw_wrap.dart';

class VWSelect extends VWFormItem {
  final VWFormItemOption option;
  final width;

  VWSelect({this.option, this.width});

  @override
  Object getText() {
    return "";
  }
  @override
  void reset() {
  }
  @override
  VWFormItemOption getOption() {
    return option;
  }

  @override
  Widget buildItem(BuildContext context) {
    return ListTile(
        title: new Text(option.label),
        subtitle: VWWrap(
          children: <Widget>[
            RaisedButton(child: const Text('正常'), onPressed: () {}),
            RaisedButton(child: const Text('草稿'), onPressed: () {}),
            RaisedButton(child: const Text('已删除'), onPressed: () {}),
            RaisedButton(child: const Text('已删除'), onPressed: () {}),
            RaisedButton(child: const Text('已删除'), onPressed: () {}),
          ],
          width: this.width ?? 80
        ));
  }
}

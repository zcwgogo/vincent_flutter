import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item_option.dart';

class VWNumber extends  VWFormItem {
  final TextEditingController _controller = new TextEditingController();
  final VWFormItemOption option;

  VWNumber({this.option});

  @override
  Object getText() {
    return _controller.text;
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
        subtitle: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: option.hintText, labelText: option.label, prefixIcon: Icon(option.icon)),
          onChanged: (String txt) {
            if (option.onChange != null) {
              option.onChange(txt);
            }
          },
          autofocus: false,
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item_option.dart';

class VWText extends VWFormItem {
  final TextEditingController _controller = new TextEditingController();
  @required
  final VWFormItemOption option;

  VWText({this.option});

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
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: option.hintText, labelText: option.label, prefixIcon: Icon(option.icon,)),
          onChanged: (String txt) {
            if (option.onChange != null) {
              option.onChange(txt);
            }
          },
          autofocus: false,
        ));
  }
}

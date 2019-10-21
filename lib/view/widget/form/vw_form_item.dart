import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item_option.dart';

abstract class VWFormItem extends StatelessWidget {
  Object getText();
  void reset();
  VWFormItemOption getOption();
  Widget buildItem(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return buildItem(context);
  }
}

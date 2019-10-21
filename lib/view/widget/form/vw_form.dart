import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vincent_flutter/src/common/DataResult.dart';
import 'package:vincent_flutter/src/net/HttpManager.dart';
import 'package:vincent_flutter/view/style/VCommonColors.dart';
import 'package:vincent_flutter/view/widget/form/vw_form_item.dart';

class VWForm extends StatelessWidget {
  @required
  final List<VWFormItem> children;
  final Widget buttons;
  final onSubmit;
  final onSuccess;
  final String url;

  VWForm({this.children, this.onSubmit, this.onSuccess, this.url, this.buttons});

  Map<String, Object> getValues({filterBlank: true}) {
    Map<String, Object> result = new Map();
    for (VWFormItem item in children) {
      if (filterBlank) {
        if (ObjectUtil.isEmptyString(item.getText())) {
          continue;
        }
      }
      result[item.getOption().name] = item.getText();
    }
    return result;
  }

  void reset() {
    for (VWFormItem item in children) {
      item.reset();
    }
  }

  void submit() async {
    DataResult result = await HttpManager.instance.request(this.url, getValues(), new Options(method: "post"));
    if (result.success) {
      if (this.onSubmit) {
        this.onSuccess(result);
      }
    } else {
//      VCommonUtils.showAlertDialog(context: c); TODO MAIN context
    }
  }

  Widget _getButtons() {
    if (this.buttons == null) {
      return ButtonBar(children: <Widget>[
        RaisedButton(
            child: const Text('重置'),
            onPressed: () {
              reset();
            }),
        RaisedButton(
            child: const Text('确定'),
            color: VCommonColors.info,
            textColor: Color(VCommonColors.white),
            onPressed: () {
              this.onSubmit != null ? this.onSubmit(this) : submit();
            }),
      ], alignment: MainAxisAlignment.end);
    }
    return this.buttons;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(padding: EdgeInsets.only(top: 20), child: ListView(children: children)),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(border: Border(top: BorderSide(width: 1.0, color: Colors.grey))),
        child: _getButtons(),
      ),
    );
  }
}

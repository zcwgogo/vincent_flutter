import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/style/VIconConstant.dart';

class VWFormItemOption {
  String text;
  String label;
  String hintText;
  String name;
  IconData icon = VIconConstant.DEFAULT_FORM_ITEM;

  String typeCode;

  //envent
  var onChange;

  static VWFormItemOption empty() {
    return VWFormItemOption();
  }

  static VWFormItemOption createInput(String name, String label, String hintText) {
    VWFormItemOption instance = VWFormItemOption();
    instance.name = name;
    instance.label = label;
    instance.hintText = hintText;
    return instance;
  }

  static VWFormItemOption createSelect(String name, String label, String typeCode) {
    VWFormItemOption instance = VWFormItemOption();
    instance.name = name;
    instance.label = label;
    instance.typeCode = typeCode;
    return instance;
  }

  static VWFormItemOption createDate(String name, String label) {
    VWFormItemOption instance = VWFormItemOption();
    instance.name = name;
    instance.label = label;
    return instance;
  }
}

import 'package:flutter/material.dart';
import 'package:vincent_flutter/view/localization/v_default_localizations.dart';
class VMessageUtils {
  static String getLocale(BuildContext context,String key) {
    return VLocalizations.of(context).currentLocalized[key] ?? key;
  }
}
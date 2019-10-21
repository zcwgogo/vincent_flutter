import 'dart:ui';

import 'package:flutter/material.dart';

import 'i18n/vi_string_en.dart';
import 'i18n/vi_string_zh.dart';

class VLocalizations {
  final Locale locale;

  VLocalizations(this.locale);

  static Map<String, Map> _localizedValues = {
    'en': new VIStringEn().localizedValues,
    'zh': new VIStringZh().localizedValues
  };

  Map<String, String> get currentLocalized {
    return _localizedValues[locale.languageCode];
  }

  ///通过 Localizations 加载当前的 GSYLocalizations
  ///获取对应的 GSYStringBase
  static VLocalizations of(BuildContext context) {
    return Localizations.of(context, VLocalizations);
  }
}

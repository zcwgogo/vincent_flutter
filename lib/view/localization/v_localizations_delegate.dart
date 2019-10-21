import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'v_default_localizations.dart';

class VLocalizationsDelegate extends LocalizationsDelegate<VLocalizations> {
  VLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<VLocalizations> load(Locale locale) {
    return new SynchronousFuture<VLocalizations>(new VLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<VLocalizations> old) {
    return false;
  }

  static VLocalizationsDelegate delegate = new VLocalizationsDelegate();
}

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = JStrings.supportedLocales[0];

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!JStrings.delegate.isSupported(locale)) {
      return;
    }

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = JStrings.supportedLocales[0]; // always take the default
    notifyListeners();
  }
}

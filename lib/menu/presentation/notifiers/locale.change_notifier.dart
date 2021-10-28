import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:kwriting/menu/menu.dart';

class LocaleChangeNotifier extends ChangeNotifier {
  LocaleChangeNotifier(this._controller);

  final AppController _controller;

  Locale get locale => _controller.locale;

  void updateLocale() {
    notifyListeners();
  }
}

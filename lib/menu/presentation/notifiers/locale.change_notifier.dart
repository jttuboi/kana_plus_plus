import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:kwriting/menu/domain/use_cases/app.controller.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(this._controller);

  final AppController _controller;

  Locale get locale => _controller.locale;

  void updateLocale() {
    notifyListeners();
  }
}

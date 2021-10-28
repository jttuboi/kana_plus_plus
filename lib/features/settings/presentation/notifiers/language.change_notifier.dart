import 'package:flutter/widgets.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class LanguageChangeNotifier extends ChangeNotifier {
  LanguageChangeNotifier(this._controller);

  final SettingsController _controller;

  String get languageSelected => _controller.languageSelected;

  List<SelectionOptionItem> options(String Function(String localeCode) languageText) {
    return JStrings.supportedLocales.map((locale) {
      return SelectionOptionItem(
        key: locale.languageCode,
        label: languageText(locale.languageCode),
      );
    }).toList();
  }

  void updateLanguageSelected(String pSelectedKey) {
    _controller.updateLanguageSelected(pSelectedKey);
    notifyListeners();
  }
}

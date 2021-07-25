import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/controllers/settings.controller.dart';
import 'package:kana_plus_plus/src/views/android/view_models/selection_option.view_model.dart';

class LanguageProvider extends ChangeNotifier {
  LanguageProvider(this._controller) {
    selectedKey = _controller.getLanguageSelected();
    notifyListeners();
  }

  final SettingsController _controller;
  final List<String> _ignoreLocaleCodes = ["pt"];

  late String selectedKey;

  String get iconUrl => _controller.getLanguageIconUrl();

  String get text => _controller.getLanguageText(selectedKey);

  List<SelectionOptionViewModel> get options {
    return JStrings.supportedLocales.where((Locale locale) {
      return !_ignoreLocaleCodes.contains(locale.toString());
    }).map((Locale locale) {
      return SelectionOptionViewModel(
        key: locale.toString(),
        label: _controller.getLanguageText(locale.toString()),
      );
    }).toList();
  }

  void updateKey(String pSelectedKey) {
    selectedKey = pSelectedKey;
    _controller.updateLanguageSelected(pSelectedKey);
    notifyListeners();
  }
}

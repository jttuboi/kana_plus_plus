import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kwriting/settings/domain/use_cases/settings.controller.dart';
import 'package:kwriting/settings/presentation/arguments/selection_option_arguments.dart';

class LanguageProvider extends ChangeNotifier {
  LanguageProvider(this._controller);

  final SettingsController _controller;

  String get languageSelected => _controller.languageSelected;

  List<SelectionOptionArguments> options(String Function(String localeCode) languageText) {
    return JStrings.supportedLocales.map((locale) {
      return SelectionOptionArguments(
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

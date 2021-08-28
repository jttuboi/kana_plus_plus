import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/domain/usecases/settings.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';

class LanguageProvider extends ChangeNotifier {
  LanguageProvider(this._controller);

  final SettingsController _controller;

  final List<String> _ignoreLocaleCodes = ['pt'];

  String get languageSelected => _controller.getLanguageSelected();

  String get iconUrl => _controller.getLanguageIconUrl();

  List<SelectionOptionArguments> getOptions(String Function(String localeCode) languageText) {
    return JStrings.supportedLocales.where((Locale locale) {
      return !_ignoreLocaleCodes.contains(locale.toString());
    }).map((Locale locale) {
      return SelectionOptionArguments(
        key: locale.toString(),
        label: languageText(locale.toString()),
      );
    }).toList();
  }

  void updateLanguageSelected(String pSelectedKey) {
    _controller.updateLanguageSelected(pSelectedKey);
    notifyListeners();
  }
}

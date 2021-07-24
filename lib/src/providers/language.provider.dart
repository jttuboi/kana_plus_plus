import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:kana_plus_plus/src/controllers/settings.controller.dart';
import 'package:kana_plus_plus/src/views/android/pages/settings.page.dart';

class LanguageProvider extends ChangeNotifier {
  LanguageProvider(this.controller) {
    selectedLanguageKey = controller.getSelectedLanguageKey();
    notifyListeners();
  }

  SettingsController controller;

  final List<String> _ignoreLocaleCodes = ["pt"];

  late String selectedLanguageKey;

  String get languageIconUrl => "lib/assets/icons/black/language.png";

  String get languageSelectedText => getLanguageText(selectedLanguageKey);

  List<SelectionOption2> get languageOptions {
    return JStrings.supportedLocales.where((Locale locale) {
      return !_ignoreLocaleCodes.contains(locale.toString());
    }).map((Locale locale) {
      final String fullName = getLanguageText(locale.toString());
      return SelectionOption2(locale.toString(), fullName);
    }).toList();
  }

  void changeLanguage(String pSelectedLanguageKey) {
    selectedLanguageKey = pSelectedLanguageKey;
    controller.updateLanguage(pSelectedLanguageKey);
    notifyListeners();
  }

  String getLanguageText(String key) {
    return LocaleNamesLocalizationsDelegate.nativeLocaleNames[key] ?? "English";
  }
}

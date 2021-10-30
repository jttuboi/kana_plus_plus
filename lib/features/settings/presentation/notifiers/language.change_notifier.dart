import 'package:flutter/widgets.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class LanguageChangeNotifier extends ChangeNotifier {
  LanguageChangeNotifier(ILanguageRepository languageRepository) {
    _getLanguage = GetLanguage(languageRepository);
    _updateLanguage = UpdateLanguage(languageRepository);

    _getLanguage(NoParams()).then((pLocaleCode) {
      localeCode = pLocaleCode;
      notifyListeners();
    });
  }

  late final GetLanguage _getLanguage;
  late final UpdateLanguage _updateLanguage;

  String localeCode = Default.locale;

  void updateLanguage(String pLocaleCode) {
    localeCode = pLocaleCode;
    _updateLanguage(LanguageParams(pLocaleCode));
    notifyListeners();
  }
}

import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/domain/repositories/language.interface.repository.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(this.languageRepository);

  final ILanguageRepository languageRepository;

  Locale get locale {
    return JStrings.supportedLocales.firstWhere((Locale locale) {
      return locale.toString() == languageRepository.getLanguageSelected();
    });
  }

  void updateLocale() {
    notifyListeners();
  }
}

import 'dart:ui';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/domain/repositories/app.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/language.interface.repository.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';

class AppController {
  AppController({required this.appRepository, required this.languageRepository});

  final IAppRepository appRepository;
  final ILanguageRepository languageRepository;

  bool get isFirstTime => appRepository.isFirstTime();

  void finishFirstTime() {
    appRepository.setFirstTime(false);
  }

  Locale get locale {
    return JStrings.supportedLocales.firstWhere((Locale locale) {
      return locale.languageCode == languageRepository.getLanguageSelected();
    });
  }

  void setDeviceLocale(Locale? deviceLocale) {
    if (deviceLocale == null) {
      // default english
      languageRepository.setLanguageSelected(defaultLocale.languageCode);
    }

    if (isFirstTime) {
      // find and set the device locale. if doesn't support it, set english by default
      final localeFound = JStrings.supportedLocales.firstWhere((Locale locale) {
        return locale.languageCode == deviceLocale!.languageCode;
      }, orElse: () {
        return defaultLocale;
      });
      languageRepository.setLanguageSelected(localeFound.languageCode);
    }

    // if it is not the first time, do nothing because the language is already saved on the app
  }
}

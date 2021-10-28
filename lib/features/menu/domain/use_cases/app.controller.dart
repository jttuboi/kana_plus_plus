import 'dart:ui';

import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/menu/menu.dart';
import 'package:kwriting/features/settings/settings.dart';

class AppController {
  AppController({required this.appRepository, required this.languageRepository});

  final defaultLocale = JStrings.supportedLocales.first;

  final IAppRepository appRepository;
  final ILanguageRepository languageRepository;

  bool get isFirstTime => appRepository.isFirstTime();

  void finishFirstTime() {
    appRepository.setFirstTime(false);
  }

  Locale get locale {
    return JStrings.supportedLocales.firstWhere((locale) {
      return locale.languageCode == languageRepository.getLanguageSelected();
    }, orElse: () {
      return defaultLocale;
    });
  }

  void setDeviceLocale(Locale? deviceLocale) {
    if (deviceLocale == null) {
      languageRepository.setLanguageSelected(defaultLocale.languageCode);
    } else if (isFirstTime) {
      final localeFound = JStrings.supportedLocales.firstWhere((locale) {
        return locale.languageCode == deviceLocale.languageCode;
      }, orElse: () {
        return defaultLocale;
      });
      languageRepository.setLanguageSelected(localeFound.languageCode);
    }

    // if it is not the first time, do nothing because the language is already saved on the app
  }
}

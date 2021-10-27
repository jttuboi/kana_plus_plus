// ignore_for_file: unnecessary_lambdas

import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/menu/domain/repositories/app.interface.repository.dart';
import 'package:kwriting/menu/domain/use_cases/app.controller.dart';
import 'package:kwriting/settings/domain/repositories/language.interface.repository.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late final appRepository = AppRepositoryMock();
  late final languageRepository = LanguageRepositoryMock();
  late final appController = AppController(appRepository: appRepository, languageRepository: languageRepository);

  group('first time', () {
    test('must return true', () {
      when(() => appRepository.isFirstTime()).thenReturn(true);

      expect(appController.isFirstTime, isTrue);
      verify(() => appRepository.isFirstTime()).called(1);
    });
    test('must return false', () {
      when(() => appRepository.isFirstTime()).thenReturn(false);

      expect(appController.isFirstTime, isFalse);
      verify(() => appRepository.isFirstTime()).called(1);
    });
    test('must called setFirstTime', () {
      appController.finishFirstTime();

      verify(() => appRepository.setFirstTime(false)).called(1);
    });
  });
  group('locale', () {
    test('must return english locale when language is "en"', () {
      when(() => languageRepository.getLanguageSelected()).thenReturn('en');
      expect(appController.locale, const Locale('en'));
    });
    test('must return portuguese locale when language is "pt"', () {
      when(() => languageRepository.getLanguageSelected()).thenReturn('pt');
      expect(appController.locale, const Locale('pt'));
    });
    test('must return spanish locale when language is "es"', () {
      when(() => languageRepository.getLanguageSelected()).thenReturn('es');
      expect(appController.locale, const Locale('es'));
    });
    test('must set portuguese language code when is locale is "pt*"', () {
      when(() => appRepository.isFirstTime()).thenReturn(true);

      appController.setDeviceLocale(const Locale('pt'));
      verify(() => languageRepository.setLanguageSelected('pt'));

      appController.setDeviceLocale(const Locale('pt', 'BR'));
      verify(() => languageRepository.setLanguageSelected('pt'));
    });
    test('must set spanish language code when is locale is "es*"', () {
      when(() => appRepository.isFirstTime()).thenReturn(true);

      appController.setDeviceLocale(const Locale('es'));
      verify(() => languageRepository.setLanguageSelected('es'));

      appController.setDeviceLocale(const Locale('es', 'US'));
      verify(() => languageRepository.setLanguageSelected('es'));
    });
    test('must set english language code when is locale is not "es*" or "pt*"', () {
      when(() => appRepository.isFirstTime()).thenReturn(true);

      appController.setDeviceLocale(const Locale('en'));
      verify(() => languageRepository.setLanguageSelected('en'));

      appController.setDeviceLocale(const Locale('en', 'NZ'));
      verify(() => languageRepository.setLanguageSelected('en'));

      appController.setDeviceLocale(const Locale('zh'));
      verify(() => languageRepository.setLanguageSelected('en'));

      appController.setDeviceLocale(const Locale('ja'));
      verify(() => languageRepository.setLanguageSelected('en'));

      appController.setDeviceLocale(const Locale('de', 'DE'));
      verify(() => languageRepository.setLanguageSelected('en'));

      appController.setDeviceLocale(const Locale('fr', 'FR'));
      verify(() => languageRepository.setLanguageSelected('en'));
    });
    test('must set english language code when is locale is null', () {
      appController.setDeviceLocale(null);
      verify(() => languageRepository.setLanguageSelected('en'));
    });
    test('must not set nothing when is first time is false and has any locale', () {
      when(() => appRepository.isFirstTime()).thenReturn(false);

      appController.setDeviceLocale(const Locale('en'));
      verifyNever(() => languageRepository.setLanguageSelected(any()));

      appController.setDeviceLocale(const Locale('pt'));
      verifyNever(() => languageRepository.setLanguageSelected(any()));

      appController.setDeviceLocale(const Locale('es'));
      verifyNever(() => languageRepository.setLanguageSelected(any()));

      appController.setDeviceLocale(const Locale('ja'));
      verifyNever(() => languageRepository.setLanguageSelected(any()));

      appController.setDeviceLocale(const Locale('fr', 'FR'));
      verifyNever(() => languageRepository.setLanguageSelected(any()));
    });
  });
}

class AppRepositoryMock extends Mock implements IAppRepository {}

class LanguageRepositoryMock extends Mock implements ILanguageRepository {}

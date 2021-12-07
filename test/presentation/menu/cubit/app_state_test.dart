// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/menu/menu.dart';

void main() {
  group('AppLoaded', () {
    test('must be equals', () {
      final appState = AppLoaded();
      expect(appState, AppLoaded());
    });

    test('sets properly', () {
      final appState = AppLoaded(isFirstTimeOpenApp: true, languageCode: 'pt');
      expect(appState.isFirstTimeOpenApp, isTrue);
      expect(appState.languageCode, 'pt');
    });

    test('copies when uses copyWith', () {
      final appState = AppLoaded(isFirstTimeOpenApp: true, languageCode: 'pt');
      expect(appState.copyWith(isFirstTimeOpenApp: false), AppLoaded(isFirstTimeOpenApp: false, languageCode: 'pt'));
      expect(appState.copyWith(languageCode: 'es'), AppLoaded(isFirstTimeOpenApp: true, languageCode: 'es'));
    });
  });

  group('AppLoadInProgress', () {
    test('must be equals', () {
      final appState = AppLoadInProgress();
      expect(appState, AppLoadInProgress());
    });
  });
}

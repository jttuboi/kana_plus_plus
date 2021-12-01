import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';

void main() {
  test('defaultTileIconColor gives the default tile icon color', () {
    expect(defaultTileIconColor, Colors.grey);
  });

  test('defaultTileIconSize gives the default tile icon size', () {
    expect(defaultTileIconSize, 40.0);
  });

  group('App', () {
    test('gives app data used', () {
      expect(App.title, 'KWriting');
      expect(App.playStoreUrl, 'https://play.google.com/store/apps/details?id=com.kana_plus_plus');
      expect(App.appStoreUrl, '');
      expect(App.androidId, 'com.kana_plus_plus');
      expect(App.iosId, '');
      expect(App.privacyPolicyUrl, 'https://tuboi-studios.github.io/kwriting_terms_of_use_and_privacy_policy');
    });
  });

  group('Developer', () {
    test('gives developer data used', () {
      expect(Developer.name, 'Jairo Toshio Tuboi');
      expect(Developer.contact, 'tuboi.studios@gmail.com');
    });
  });

  group('Default', () {
    test('gives default data used', () {
      expect(Default.languageCode, 'en');
      expect(Default.minimumTrainingCards, 5);
      expect(Default.maximumTrainingCards, 20);
      expect(Default.showHint, true);
      expect(Default.firstTime, true);
      expect(Default.contactSubject, 'Contact via KWriting');
      expect(Default.emailSubject, 'Learn hiragana/katakana on KWriting');
    });
  });

  group('Ads', () {
    // don't need test because it's an important information
  });

  test('toLanguageText converts to language text from language code', () {
    expect(toLanguageText('en'), 'English');
    expect(toLanguageText('es'), 'Español');
    expect(toLanguageText('pt'), 'Português brasileiro');
    expect(toLanguageText(''), 'English');
  });

  group('BoxTag', () {
    test('gives box tag data used', () {
      expect(BoxTag.app, 'app');
      expect(BoxTag.settings, 'settings');
      expect(BoxTag.statisticCount, 'statisticCount');
      expect(BoxTag.statisticObjects, 'statisticObjects');
    });
  });

  group('DatabaseTag', () {
    test('gives database tag data used', () {
      expect(DatabaseTag.language, 'language');
      expect(DatabaseTag.showHint, 'show_hint');
      expect(DatabaseTag.kanaType, 'kana_type');
      expect(DatabaseTag.quantityOfWords, 'quantity_of_words');
      expect(DatabaseTag.firstTime, 'first_time');
      expect(DatabaseTag.showHintQuantity, 'show_hint_quantity');
      expect(DatabaseTag.notShowHintQuantity, 'not_show_hint_quantity');
      expect(DatabaseTag.onlyHiraganaQuantity, 'only_hiragana_quantity');
      expect(DatabaseTag.onlyKatakanaQuantity, 'only_katakana_quantity');
      expect(DatabaseTag.bothQuantity, 'both_quantity');
      expect(DatabaseTag.trainingQuantity, 'training_quantity');
      expect(DatabaseTag.wordCorrectQuantity, 'word_correct_quantity');
      expect(DatabaseTag.wordWrongQuantity, 'word_wrong_quantity');
      expect(DatabaseTag.kanaCorrectQuantity, 'kana_correct_quantity');
      expect(DatabaseTag.kanaWrongQuantity, 'kana_wrong_quantity');
      expect(DatabaseTag.trainingStats, 'training_stats');
      expect(DatabaseTag.specificWordCorrectQuantity, 'specificWordCorrectQuantity');
      expect(DatabaseTag.specificWordWrongQuantity, 'specificWordWrongQuantity');
      expect(DatabaseTag.specificKanaCorrectQuantity, 'specificKanaCorrectQuantity');
      expect(DatabaseTag.specificKanaWrongQuantity, 'specificKanaWrongQuantity');
      expect(DatabaseTag.keySpecificWordCorrectQuantity('あめ'), 'correct_word_354417');
      expect(DatabaseTag.keySpecificWordWrongQuantity('あめ'), 'wrong_word_354417');
      expect(DatabaseTag.keySpecificKanaCorrectQuantity('あ'), 'correct_kana_354');
      expect(DatabaseTag.keySpecificKanaWrongQuantity('あ'), 'wrong_kana_354');
    });
  });

  group('FileUrl', () {
    test('gives file url data used', () {
      expect(FileUrl.kanas, 'assets/database/kanas.json');
      expect(FileUrl.translates, 'assets/database/translates.json');
      expect(FileUrl.words, 'assets/database/words.json');
      expect(FileUrl.points, 'assets/database/points.json');
    });
  });

  test('toKanaType converts to kana type from data of database', () {
    expect(toKanaType('h'), KanaType.hiragana);
    expect(toKanaType('k'), KanaType.katakana);
    expect(toKanaType('b'), KanaType.both);
    expect(toKanaType(''), KanaType.both);
  });
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kwriting/domain/domain.dart';

double appBarExpandedHeight(BuildContext context) {
  return MediaQuery.of(context).size.height * 1 / 5;
}

const defaultTileIconColor = Colors.grey;
const defaultTileIconSize = 40.0;

class App {
  App._();

  static const title = 'KWriting';

  static const playStoreUrl = 'https://play.google.com/store/apps/details?id=com.kana_plus_plus';
  static const appStoreUrl = '';

  static const androidId = 'com.kana_plus_plus';
  static const iosId = '';

  static const privacyPolicyUrl = 'https://tuboi-studios.github.io/kwriting_terms_of_use_and_privacy_policy';
}

class Developer {
  Developer._();

  static const name = 'Jairo Toshio Tuboi';
  static const contact = 'tuboi.studios@gmail.com';
}

class Default {
  Default._();

  static const languageCode = 'en';
  static const minimumTrainingCards = 5;
  static const maximumTrainingCards = 20;
  static const showHint = true;
  static const firstTime = true;

  static const contactSubject = 'Contact via KWriting';
  static const emailSubject = 'Learn hiragana/katakana on KWriting';
}

String get interstitialAdUnitId {
  if (Platform.isAndroid) {
    //return 'ca-app-pub-3940256099942544/1033173712'; // interstitial image
    return 'ca-app-pub-3940256099942544/8691691433'; // interstitial video
  } else if (Platform.isIOS) {
    return 'interstitial IOS UNIT ID';
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}

String toLanguageText(String localeCode) {
  if (localeCode == 'es') {
    return 'Español';
  } else if (localeCode == 'pt') {
    return 'Português brasileiro';
  }
  return 'English';
}

class BoxTag {
  BoxTag._();
  static const app = 'app';
  static const settings = 'settings';
  static const statisticCount = 'statisticCount';
  static const statisticObjects = 'statisticObjects';
}

class DatabaseTag {
  DatabaseTag._();
  static const language = 'language';
  static const showHint = 'show_hint';
  static const kanaType = 'kana_type';
  static const quantityOfWords = 'quantity_of_words';
  static const firstTime = 'first_time';
  static const showHintQuantity = 'show_hint_quantity';
  static const notShowHintQuantity = 'not_show_hint_quantity';
  static const onlyHiraganaQuantity = 'only_hiragana_quantity';
  static const onlyKatakanaQuantity = 'only_katakana_quantity';
  static const bothQuantity = 'both_quantity';
  static const trainingQuantity = 'training_quantity';
  static const wordCorrectQuantity = 'word_correct_quantity';
  static const wordWrongQuantity = 'word_wrong_quantity';
  static const kanaCorrectQuantity = 'kana_correct_quantity';
  static const kanaWrongQuantity = 'kana_wrong_quantity';
  static const trainingStats = 'training_stats';
  static const specificWordCorrectQuantity = 'specificWordCorrectQuantity';
  static const specificWordWrongQuantity = 'specificWordWrongQuantity';
  static const specificKanaCorrectQuantity = 'specificKanaCorrectQuantity';
  static const specificKanaWrongQuantity = 'specificKanaWrongQuantity';
  static String keySpecificWordCorrectQuantity(String wordId) => 'correct_word_${_getCode(wordId)}';
  static String keySpecificWordWrongQuantity(String wordId) => 'wrong_word_${_getCode(wordId)}';
  static String keySpecificKanaCorrectQuantity(String kanaId) => 'correct_kana_${_getCode(kanaId)}';
  static String keySpecificKanaWrongQuantity(String kanaId) => 'wrong_kana_${_getCode(kanaId)}';
  static String _getCode(String id) => id.codeUnits.fold<String>('', (str, code) => str + '$code'.substring(2, 5));
}

class FileUrl {
  FileUrl._();
  static const kanas = 'assets/database/kanas.json';
  static const translates = 'assets/database/translates.json';
  static const words = 'assets/database/words.json';
  static const points = 'assets/database/points.json';
}

KanaType toKanaType(String data) {
  if (data == 'h') {
    return KanaType.hiragana;
  } else if (data == 'k') {
    return KanaType.katakana;
  }
  return KanaType.both;
}

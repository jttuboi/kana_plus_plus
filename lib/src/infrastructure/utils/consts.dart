import 'package:kwriting/src/domain/utils/kana_type.dart';

const databaseName = 'kwriting_database.db';
const databaseVersion = 1;

class TWords {
  TWords._();
  static const id = 'id';
  static const romaji = 'romaji';
  static const type = 'type';
  static const imageUrl = 'imageUrl';
}

class TKanas {
  TKanas._();
  static const id = 'id';
  static const type = 'type';
  static const imageUrl = 'imageUrl';
  static const romaji = 'romaji';
  static const strokesQuantity = 'strokesQuantity';
}

class TTranslates {
  TTranslates._();
  static const id = 'id';
  static const english = 'en';
  static const portuguese = 'pt';
  static const spanish = 'es';
}

class DatabaseTag {
  DatabaseTag._();
  static const language = 'language';
  static const writingHand = 'writing_hand';
  static const darkTheme = 'dark_theme';
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
}

class FileUrl {
  static const kanas = 'assets/database/kanas.json';
  static const translates = 'assets/database/translates.json';
  static const words = 'assets/database/words.json';
}

KanaType toKanaType(String data) {
  if (data == 'h') {
    return KanaType.hiragana;
  } else if (data == 'k') {
    return KanaType.katakana;
  } else if (data == 'b') {
    return KanaType.both;
  }
  return KanaType.none;
}

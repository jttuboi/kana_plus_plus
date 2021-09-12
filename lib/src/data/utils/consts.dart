import 'package:kana_plus_plus/src/domain/core/kana_type.dart';

const databaseName = 'kana_plus_plus_database.db';
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
}

class FileUrl {
  static const translates = 'lib/assets/database/translates.json';
  static const kanas = 'lib/assets/database/kanas.json';
  static const words = 'lib/assets/database/words.json';
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

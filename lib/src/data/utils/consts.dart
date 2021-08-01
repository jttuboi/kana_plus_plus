const databaseName = "kana_plus_plus_database.db";

class TWords {
  TWords._();

  static const words = "words";

  static const wordId = "word_id";
  static const word = "word";
  static const romaji = "romaji";
  static const type = "type";
  static const imageUrl = "image_url";
}

class TKanas {
  TKanas._();

  static const kanas = "kanas";

  static const kanaId = "kana_id";
  static const kana = "kana";
  static const imageUrl = "image_url";
  static const romaji = "romaji";
  static const romajiImageUrl = "romaji_image_url";
}

class TTranslates {
  TTranslates._();

  static const translates = "translates";

  static const wordId = "word_id";
  static const code = "code";
  static const translate = "translate";
}

class TWordKana {
  TWordKana._();

  static const wordKana = "word_kana";

  static const wordId = "word_id";
  static const kanaId = "kana_id";
  static const sequential = "sequential";
}

class SettingsPref {
  SettingsPref._();

  static const language = "language";
  static const writingHand = "writing_hand";
  static const darkTheme = "dark_theme";
  static const showHint = "show_hint";
  static const kanaType = "kana_type";
  static const quantityOfWords = "quantity_of_words";
}

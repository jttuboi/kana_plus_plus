const databaseName = "kana_plus_plus_database.db";

class TWords {
  static const words = "words";

  static const wordId = "word_id";
  static const word = "word";
  static const romaji = "romaji";
  static const type = "type";
  static const imageUrl = "image_url";
}

class TKanas {
  static const kanas = "kanas";

  static const kanaId = "kana_id";
  static const kana = "kana";
  static const imageUrl = "image_url";
  static const romaji = "romaji";
  static const romajiImageUrl = "romaji_image_url";
}

class TTranslates {
  static const translates = "translates";

  static const wordId = "word_id";
  static const code = "code";
  static const translate = "translate";
}

class TWordKana {
  static const wordKana = "word_kana";

  static const wordId = "word_id";
  static const kanaId = "kana_id";
}

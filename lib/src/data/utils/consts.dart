const databaseName = "kana_plus_plus_database.db";

class Table {
  static const words = "words";
  static const kanas = "kanas";
  static const translates = "translates";
  static const wordKana = "word_kana";
}

class Column {
  static const wordId = "word_id";
  static const word = "word";
  static const romaji = "romaji";
  static const type = "type";
  static const imageUrl = "image_url";
  static const kanaId = "kana_id";
  static const kana = "kana";
  static const romajiImageUrl = "romaji_image_url";
  static const code = "code";
  static const translate = "translate";
}

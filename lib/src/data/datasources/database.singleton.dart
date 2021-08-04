import 'package:kana_plus_plus/src/data/datasources/interfaces/database.storage.interface.dart';
import 'package:kana_plus_plus/src/data/models/word.model.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';

class Database {
  // singleton
  factory Database() => _instance;
  Database._internal();
  static final Database _instance = Database._internal();

  static late IDatabaseStorage _storage;

  static Future<void> init({required IDatabaseStorage storage}) async {
    _storage = storage;
    await _storage.init();
  }

  static Future<List<WordModel>> getWords(String languageCode) async {
    return _storage.getWords(languageCode);
  }

  static Future<List<WordModel>> getWordsById(
      int id, String languageCode) async {
    return _storage.getWordsById(id, languageCode);
  }

  static Future<List<WordModel>> getWordsByQuery(
      String query, String languageCode) async {
    return _storage.getWordsByQuery(query, languageCode);
  }

  static Future<WordModel> getWord(int id, String languageCode) async {
    return _storage.getWord(id, languageCode);
  }

  static Future<List<WordModel>> getWordsByIds(
      List<int> ids, KanaType kanaType) async {
    return _storage.getWordsByIds(ids, kanaType);
  }
}

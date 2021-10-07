import 'package:kwriting/src/data/datasources/file.interface.storage.dart';
import 'package:kwriting/src/data/models/word.model.dart';
import 'package:kwriting/src/domain/utils/kana_type.dart';

class File {
  // singleton
  factory File() => _instance;
  File._internal();
  static final File _instance = File._internal();

  static late IFileStorage _storage;

  // init cache storage. this init() is recommend to start before runApp().
  static Future<void> init({required IFileStorage storage}) async {
    _storage = storage;
    await _storage.init();
  }

  static List<WordModel> getWords() {
    return _storage.getWords();
  }

  static List<WordModel> getWordsById(String id) {
    return _storage.getWordsById(id);
  }

  static List<WordModel> getWordsByQuery(String query, String languageCode) {
    return _storage.getWordsByQuery(query, languageCode);
  }

  static WordModel getWord(String id) {
    return _storage.getWord(id);
  }

  static List<WordModel> getWordsByKanaType(KanaType kanaType) {
    return _storage.getWordsByKanaType(kanaType);
  }
}

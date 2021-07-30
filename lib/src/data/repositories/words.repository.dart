import 'package:kana_plus_plus/src/data/datasources/cache.singleton.dart';
import 'package:kana_plus_plus/src/data/datasources/database.singleton.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/domain/repositories/words.interface.dart';

class WordsRepository implements IWordsRepository {
  @override
  Future<List<Word>> getWords() async {
    final languageCode = Cache.getString("language", defaultValue: "en");
    return Database.getWords(languageCode);
  }

  @override
  Future<List<Word>> getWordsById(int id) async {
    final languageCode = Cache.getString("language", defaultValue: "en");
    return Database.getWordsById(id, languageCode);
  }

  @override
  Future<List<Word>> getWordsByQuery(String query) async {
    final languageCode = Cache.getString("language", defaultValue: "en");
    return Database.getWordsByQuery(query, languageCode);
  }

  @override
  Future<Word> getWord(int id) async {
    final languageCode = Cache.getString("language", defaultValue: "en");
    return Database.getWord(id, languageCode);
  }
}

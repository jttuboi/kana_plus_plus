import 'package:kana_plus_plus/src/data/datasources/cache.singleton.dart';
import 'package:kana_plus_plus/src/data/datasources/database.singleton.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/domain/repositories/word.interface.repository.dart';

class WordRepository implements IWordRepository {
  @override
  Future<List<Word>> getWords() async {
    final languageCode = Cache.getString("language", defaultValue: Default.locale);
    return Database.getWords(languageCode);
  }

  @override
  Future<List<Word>> getWordsById(int id) async {
    final languageCode = Cache.getString("language", defaultValue: Default.locale);
    return Database.getWordsById(id, languageCode);
  }

  @override
  Future<List<Word>> getWordsByQuery(String query) async {
    final languageCode = Cache.getString("language", defaultValue: Default.locale);
    return Database.getWordsByQuery(query, languageCode);
  }

  @override
  Future<Word> getWord(int id) async {
    final languageCode = Cache.getString("language", defaultValue: Default.locale);
    return Database.getWord(id, languageCode);
  }

  @override
  Future<List<Word>> getWordsByIds(List<int> ids, KanaType kanaType) async {
    return Database.getWordsByIds(ids, kanaType);
  }
}

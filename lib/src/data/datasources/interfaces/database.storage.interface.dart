import 'package:kana_plus_plus/src/data/models/word.model.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';

abstract class IDatabaseStorage {
  Future<void> init();

  Future close();

  Future<List<WordModel>> getWords(String languageCode);

  Future<List<Word>> getWordsById(int id, String languageCode);

  Future<List<Word>> getWordsByQuery(String query, String languageCode);

  Future<WordModel> getWord(int id, String languageCode);
}

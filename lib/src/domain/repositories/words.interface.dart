import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';

abstract class IWordsRepository {
  Future<List<Word>> getWords();

  Future<List<Word>> getWordsById(int id);

  Future<List<Word>> getWordsByQuery(String query);

  Future<Word> getWord(int id);
}

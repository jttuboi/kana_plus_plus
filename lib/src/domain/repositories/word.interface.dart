import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';

abstract class IWordRepository {
  Future<List<Word>> getWords();

  Future<List<Word>> getWordsById(int id);

  Future<List<Word>> getWordsByQuery(String query);

  Future<Word> getWord(int id);

  Future<List<Word>> getWordsByIds(List<int> ids, KanaType kanaType);
}

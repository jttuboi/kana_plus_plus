import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';

abstract class IWordsRepository {
  Future<List<Word>> getWords();

  List<Word> getWordsBy(String textSearch);

  Future<Word> getWord(int id);
}

import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';

abstract class IWordsRepository {
  Future<List<Word>> getWords(String languageCode);

  List<Word> getWordsBy(String textSearch);

  Word getWord(String id);
}

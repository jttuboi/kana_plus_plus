import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';

abstract class IWordRepository {
  List<Word> getWords();

  List<Word> getWordsById(String id);

  List<Word> getWordsByQuery(String query);

  Word getWord(String id);

  List<Word> getWordsByIds(List<String> ids);
}

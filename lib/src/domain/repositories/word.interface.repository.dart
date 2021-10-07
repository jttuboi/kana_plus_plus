import 'package:kwriting/src/domain/entities/word.dart';
import 'package:kwriting/src/domain/utils/kana_type.dart';

abstract class IWordRepository {
  List<Word> getWords();

  List<Word> getWordsById(String id);

  List<Word> getWordsByQuery(String query);

  Word getWord(String id);

  List<Word> getWordsForTraining(KanaType kanaType, int quantityOfWords);
}

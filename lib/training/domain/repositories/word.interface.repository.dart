import 'package:kwriting/core/core.dart';
import 'package:kwriting/training/training.dart';

abstract class IWordRepository {
  List<Word> getWords();

  List<Word> getWordsById(String id);

  List<Word> getWordsByQuery(String query);

  Word getWord(String id);

  List<Word> getWordsForTraining(KanaType kanaType, int quantityOfWords);
}

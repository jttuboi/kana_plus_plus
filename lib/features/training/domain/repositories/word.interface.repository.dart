import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/features/training/training.dart';

abstract class IWordRepository {
  List<Word> getWords();

  List<Word> getWordsById(String id);

  List<Word> getWordsByQuery(String query);

  Word getWord(String id);

  List<Word> getWordsForTraining(KanaType kanaType, int quantityOfWords);
}

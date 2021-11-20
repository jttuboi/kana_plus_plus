import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/training/training.dart';

abstract class IFileStorage {
  Future<void> initialize();

  List<WordModel> getWords();

  List<WordModel> getWordsById(String id);

  List<WordModel> getWordsByQuery(String query, String languageCode);

  WordModel getWord(String id);

  List<WordModel> getWordsByKanaType(KanaType kanaType);
}

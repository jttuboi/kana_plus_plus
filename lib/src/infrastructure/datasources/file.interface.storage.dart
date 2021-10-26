import 'package:kwriting/src/domain/utils/kana_type.dart';
import 'package:kwriting/src/infrastructure/models/word.model.dart';

abstract class IFileStorage {
  Future<void> init();

  List<WordModel> getWords();

  List<WordModel> getWordsById(String id);

  List<WordModel> getWordsByQuery(String query, String languageCode);

  WordModel getWord(String id);

  List<WordModel> getWordsByKanaType(KanaType kanaType);
}

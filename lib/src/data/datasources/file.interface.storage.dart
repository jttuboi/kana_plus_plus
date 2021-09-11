import 'package:kana_plus_plus/src/data/models/word.model.dart';
import 'package:kana_plus_plus/src/domain/core/kana_type.dart';

abstract class IFileStorage {
  Future<void> init();

  List<WordModel> getWords();

  List<WordModel> getWordsById(String id);

  List<WordModel> getWordsByQuery(String query, String languageCode);

  WordModel getWord(String id);

  List<WordModel> getWordsByKanaType(KanaType kanaType);
}

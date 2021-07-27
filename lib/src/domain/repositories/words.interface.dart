import 'package:kana_plus_plus/src/data/models/word.model.dart';

abstract class IWordsRepository {
  List<WordModel> getWords();

  List<WordModel> getWordsBy(String textSearch);

  WordModel getWord(String id);
}

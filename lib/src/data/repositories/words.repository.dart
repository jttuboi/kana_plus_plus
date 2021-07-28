import 'package:kana_plus_plus/src/data/datasources/database.singleton.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/domain/repositories/words.interface.dart';

class WordsRepository implements IWordsRepository {
  @override
  Future<List<Word>> getWords(String languageCode) async {
    return Database.getWords(languageCode);
  }

  @override
  List<Word> getWordsBy(String textSearch) {
    // TODO: implement getWordsBy
    throw UnimplementedError();
  }

  @override
  Word getWord(String id) {
    // TODO: implement getWord
    throw UnimplementedError();
  }
}

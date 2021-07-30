import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/domain/repositories/words.interface.dart';

class WordsController {
  const WordsController(this.repository);

  final IWordsRepository repository;

  Future<List<Word>> showAllWords() async {
    return repository.getWords();
  }

  Future<Word> showWordDetail(int id) async {
    return repository.getWord(id);
  }
}

import 'package:kana_plus_plus/src/domain/entities/loaded_by.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/domain/repositories/words.interface.dart';

class WordsController {
  WordsController({required this.wordsRepository});

  final IWordsRepository wordsRepository;

  LoadedBy _loadedBy = LoadedBy.none;
  int _id = -1;
  String _query = "";

  Future<List<Word>> showWords() {
    if (_loadedBy.isLoadedById) {
      return wordsRepository.getWordsById(_id);
    } else if (_loadedBy.isLoadedByQuery) {
      return wordsRepository.getWordsByQuery(_query);
    }
    return wordsRepository.getWords();
  }

  Future<Word> showWordDetail(int id) async {
    return wordsRepository.getWord(id);
  }

  void setToLoadWordsById(int id) {
    _loadedBy = LoadedBy.id;
    _id = id;
  }

  void setToLoadWordsByQuery(String query) {
    _loadedBy = LoadedBy.query;
    _query = query;
  }

  void setToLoadAllWords() {
    _loadedBy = LoadedBy.none;
  }
}

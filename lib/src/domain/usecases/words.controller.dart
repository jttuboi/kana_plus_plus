import 'package:kana_plus_plus/src/domain/entities/loaded_by.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/domain/repositories/words.interface.dart';

class WordsController {
  WordsController(this._repository);

  final IWordsRepository _repository;

  LoadedBy _loadedBy = LoadedBy.none;
  int _id = -1;
  String _query = "";

  Future<List<Word>> showWords() {
    if (_loadedBy.isLoadedById) {
      return _repository.getWordsById(_id);
    } else if (_loadedBy.isLoadedByQuery) {
      return _repository.getWordsByQuery(_query);
    }
    return _repository.getWords();
  }

  Future<Word> showWordDetail(int id) async {
    return _repository.getWord(id);
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

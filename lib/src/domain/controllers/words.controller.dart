import 'package:kana_plus_plus/src/domain/enums/loaded_by.dart';
import 'package:kana_plus_plus/src/domain/entities/word.dart';
import 'package:kana_plus_plus/src/domain/repositories/word.interface.repository.dart';

class WordsController {
  WordsController({required this.wordRepository});

  final IWordRepository wordRepository;

  LoadedBy _loadedBy = LoadedBy.none;
  String _id = '';
  String _query = '';

  List<Word> showWords() {
    if (_loadedBy.isLoadedById) {
      return wordRepository.getWordsById(_id);
    } else if (_loadedBy.isLoadedByQuery) {
      final wordsByQuery = wordRepository.getWordsByQuery(_query);
      return wordsByQuery;
    }
    return wordRepository.getWords();
  }

  Word showWordDetail(String id) {
    return wordRepository.getWord(id);
  }

  void setToLoadWordsById(String id) {
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

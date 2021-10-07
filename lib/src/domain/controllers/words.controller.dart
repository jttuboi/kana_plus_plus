import 'package:kwriting/src/domain/entities/word.dart';
import 'package:kwriting/src/domain/repositories/word.interface.repository.dart';
import 'package:kwriting/src/domain/utils/loaded_by.dart';

class WordsController {
  WordsController({required this.wordRepository});

  final IWordRepository wordRepository;

  LoadedBy _loadedBy = LoadedBy.none;
  String _id = '';
  String _query = '';

  List<Word> get allWords => wordRepository.getWords();

  List<Word> get wordsToShow {
    if (_loadedBy.isLoadedById) {
      return wordRepository.getWordsById(_id);
    } else if (_loadedBy.isLoadedByQuery) {
      final wordsByQuery = wordRepository.getWordsByQuery(_query);
      return wordsByQuery;
    }
    return wordRepository.getWords();
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

  Word wordDetail(String id) {
    return wordRepository.getWord(id);
  }
}

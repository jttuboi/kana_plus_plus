import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/entities/word.dart';
import 'package:kana_plus_plus/src/domain/usecases/words.controller.dart';

class WordsStateManagement extends ChangeNotifier {
  WordsStateManagement(this._controller);

  final WordsController _controller;

  // is used for search only (for suggestions).
  // it filled at the moment the first wordsLoading is completed.
  // after this, it doesn't fill anymore because the first set is all words.
  List<Word> wordsLoaded = [];

  Future<List<Word>> get wordsLoading async => _controller.showWords();

  Future<Word> findWord(String id) async {
    return _controller.showWordDetail(id);
  }

  void fetchWords(dynamic queryResult) {
    if (queryResult is Word) {
      _controller.setToLoadWordsById(queryResult.id);
    } else if (queryResult is String && queryResult.isNotEmpty) {
      _controller.setToLoadWordsByQuery(queryResult);
    } else {
      _controller.setToLoadAllWords();
    }
    notifyListeners();
  }
}

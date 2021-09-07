import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/entities/word.dart';
import 'package:kana_plus_plus/src/domain/controllers/words.controller.dart';

class WordsProvider extends ChangeNotifier {
  WordsProvider(this._controller);

  final WordsController _controller;

  List<Word> get wordsToShow => _controller.wordsToShow;

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

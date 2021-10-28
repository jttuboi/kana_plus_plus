import 'package:flutter/foundation.dart';
import 'package:kwriting/training/training.dart';
import 'package:kwriting/words/words.dart';

class WordsChangeNotifier extends ChangeNotifier {
  WordsChangeNotifier(this._controller);

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

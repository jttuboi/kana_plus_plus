import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/usecases/training.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';

class TrainingWordStateManagement extends ChangeNotifier {
  TrainingWordStateManagement(this._controller);

  final TrainingController _controller;

  int get wordIdx => _controller.wordIdx;

  String get currentImageUrl => _controller.currentImageUrl;

  int get numberOfWordsToStudy => _controller.wordsToTraining.length;

  List<WordResult> get wordsResult => _controller.wordsResult;

  bool get isTheLastWord => _controller.isTheLastWord;

  void updateComponents() {
    notifyListeners();
  }
}

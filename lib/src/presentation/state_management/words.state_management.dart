import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/domain/usecases/words.controller.dart';

class WordsStateManagement {
  WordsStateManagement(this._controller);

  final WordsController _controller;

  Future<List<Word>> get list async => _controller.showAllWords();

  Future<Word> findWord(int id) async {
    return _controller.showWordDetail(id);
  }
}

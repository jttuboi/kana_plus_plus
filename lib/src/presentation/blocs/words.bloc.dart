import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/domain/repositories/words.interface.dart';

class WordsBloc {
  WordsBloc(this._repository);

  final IWordsRepository _repository;

  Future<List<Word>> list(String languageCode) async =>
      _repository.getWords(languageCode);
}

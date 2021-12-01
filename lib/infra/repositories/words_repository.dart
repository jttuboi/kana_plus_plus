import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';

class WordsRepository implements IWordsRepository {
  @override
  Future<List<WordModel>> fetchTodos() async {
    return File.storage.getAllWords();
  }
}

import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/words/words.dart';

class FetchWords implements UseCase<List<Word>, Params> {
  FetchWords(this.wordsRepository);

  final IWordsRepository wordsRepository;

  @override
  Future<List<Word>> call(Params params) async {
    return wordsRepository.fetchTodos();
  }
}

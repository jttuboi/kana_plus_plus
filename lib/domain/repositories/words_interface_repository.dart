// ignore_for_file: one_member_abstracts

import 'package:kwriting/presentation/words/words.dart';

abstract class IWordsRepository {
  Future<List<Word>> fetchTodos();
}

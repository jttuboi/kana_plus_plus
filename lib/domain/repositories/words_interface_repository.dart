// ignore_for_file: one_member_abstracts

import 'package:kwriting/domain/domain.dart';

abstract class IWordsRepository {
  Future<List<WordModel>> fetchTodos();
}

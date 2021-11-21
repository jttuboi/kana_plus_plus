import 'package:kwriting/core/core.dart';
import 'package:kwriting/core/shared_entities/word.model.dart';

abstract class IFileStorage {
  Future<void> initialize();

  List<WordModel> getAllWords();
}

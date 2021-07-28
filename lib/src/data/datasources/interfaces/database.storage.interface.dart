import 'package:kana_plus_plus/src/data/models/word.model.dart';

abstract class IDatabaseStorage {
  Future<void> init();

  Future close();

  Future<List<WordModel>> getWords(String languageCode);
}

import 'package:hive/hive.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/words/words.dart';

class WordsRepository implements IWordsRepository {
  late Box _box;

  Future<void> load() async {
    _box = (Hive.isBoxOpen(BoxTag.settings)) ? Hive.box(BoxTag.settings) : await Hive.openBox(BoxTag.settings);
  }

  @override
  Future<List<Word>> fetchTodos() async {
    await load();
    final languageCode = _box.get(DatabaseTag.language, defaultValue: Default.languageCode);
    final wordsModel = File.storage.getAllWords();

    return wordsModel.map((wordModel) => Word.fromWordModel(wordModel, languageCode: languageCode)).toList();
  }
}

import 'package:hive/hive.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/domain/domain.dart';

class QuantityOfWordsRepository implements IQuantityOfWordsRepository {
  late Box _box;

  Future<void> load() async {
    _box = (Hive.isBoxOpen(BoxTag.settings)) ? Hive.box(BoxTag.settings) : await Hive.openBox(BoxTag.settings);
  }

  @override
  Future<int> getQuantityOfWords() async {
    await load();
    return _box.get(DatabaseTag.quantityOfWords, defaultValue: Default.minimumTrainingCards);
  }

  @override
  Future<void> updateQuantityOfWords(int quantityOfWords) async {
    await load();
    await _box.put(DatabaseTag.quantityOfWords, quantityOfWords);
  }
}

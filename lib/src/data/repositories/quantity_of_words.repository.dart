import 'package:kana_plus_plus/src/data/datasources/cache.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/domain/repositories/quantity_of_words.interface.repository.dart';

class QuantityOfWordsRepository implements IQuantityOfWordsRepository {
  @override
  int getQuantityOfWords() {
    return Cache.getInt(SettingsPref.quantityOfWords, defaultValue: Default.minimumTrainingCards);
  }

  @override
  void setQuantityOfWords(int value) {
    Cache.setInt(SettingsPref.quantityOfWords, value);
  }
}

import 'package:kana_plus_plus/src/data/datasources/cache.singleton.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/repositories/quantity_of_words.interface.dart';

class QuantityOfWordsRepository implements IQuantityOfWordsRepository {
  @override
  int getQuantityOfWords() {
    return Cache.getInt(SettingsPref.quantityOfWords, defaultValue: 5);
  }

  @override
  void setQuantityOfWords(int value) {
    Cache.setInt(SettingsPref.quantityOfWords, value);
  }

  @override
  double getMinWords() {
    return 5.0;
  }

  @override
  double getMaxWords() {
    return 20.0;
  }
}
